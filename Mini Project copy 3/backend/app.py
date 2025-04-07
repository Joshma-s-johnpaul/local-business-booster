from flask import Flask, render_template, request, jsonify, session, redirect, url_for, Response
from werkzeug.security import generate_password_hash, check_password_hash
import psycopg2
from datetime import datetime, timedelta
import os
import json
from flask_cors import CORS
import random

app = Flask(__name__, 
    template_folder="templates", 
    static_folder="static",
    static_url_path='/static'
)
CORS(app)
app.secret_key = "1147c6052f38bf62da455a38a426619e3c3311d0928e5d964ba2d94ec32d64a3"

# ---------------- DATABASE CONNECTION ----------------
def get_db_connection():
    try:
        conn = psycopg2.connect(
            dbname="business_db",
            user="postgres",
            password="yourpassword",
            host="localhost",
            port="5432"
        )
        print("Database connection successful")
        return conn
    except Exception as e:
        print(f"Database connection error: {str(e)}")
        raise

# ---------------- GENERATE UNIQUE BUSINESS ID ----------------
def generate_business_id():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT COUNT(*) FROM businesses")
        count = cur.fetchone()[0]
        cur.close()
        conn.close()
        return f"b{count + 1}"
    except Exception as e:
        print(f"Error generating business ID: {str(e)}")
        raise

# ---------------- REGISTER PAGE ----------------
@app.route("/register")
def register_page():
    return render_template("register.html")

# ---------------- BUSINESS REGISTRATION ----------------
@app.route("/register", methods=["POST"])
def register():
    try:
        data = request.get_json()
        print("Received registration data:", data)
        
        business_name = data.get("business_name")
        business_category = data.get("category")
        location = data.get("location")
        address = data.get("address")
        password = data.get("password")

        if not all([business_name, business_category, location, address, password]):
            return jsonify({"error": "All fields are required"}), 400

        conn = get_db_connection()
        cur = conn.cursor()

        cur.execute("SELECT 1 FROM businesses WHERE business_name = %s AND location = %s", (business_name, location))
        if cur.fetchone():
            cur.close()
            conn.close()
            return jsonify({"error": "Business already registered"}), 400

        new_business_id = generate_business_id()
        hashed_password = generate_password_hash(password)

        cur.execute("""
            INSERT INTO businesses (business_id, business_name, category, location, address, password)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (new_business_id, business_name, business_category, location, address, hashed_password))
        conn.commit()
        cur.close()
        conn.close()

        return jsonify({
            "message": "Registration successful",
            "business_id": new_business_id
        }), 200

    except Exception as e:
        print(f"Registration error: {str(e)}")
        return jsonify({"error": "An error occurred during registration"}), 500

# ---------------- LOGIN ----------------
@app.route("/login", methods=["POST"])
def login():
    try:
        data = request.get_json()
        print("Received login request with data:", data)
        
        if not data:
            print("No JSON data received")
            return jsonify({"message": "Invalid request format"}), 400
            
        business_id = data.get("business_id")
        password = data.get("password")
        
        if not business_id or not password:
            print("Missing Business ID or Password")
            return jsonify({"message": "Business ID and password are required"}), 400

        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT business_id, password FROM businesses WHERE business_id = %s", (business_id,))
        result = cur.fetchone()
        cur.close()
        conn.close()

        if not result:
            print(f"Business ID not found: {business_id}")
            return jsonify({"message": "Invalid Business ID or Password"}), 401

        stored_business_id, stored_password = result
        
        if check_password_hash(stored_password, password):
            session["business_id"] = business_id
            session.permanent = True
            print(f"✅ Login successful for Business ID: {business_id}")
            return jsonify({"message": "Login successful", "redirect": url_for("dashboard")}), 200
        else:
            print(f"❌ Invalid password for Business ID: {business_id}")
            return jsonify({"message": "Invalid Business ID or Password"}), 401

    except Exception as e:
        print(f"⚠️ Login error: {str(e)}")
        return jsonify({"message": "An error occurred during login"}), 500

# ---------------- LOGOUT ----------------
@app.route("/logout")
def logout():
    session.pop("business_id", None)
    return redirect(url_for("home"))

# ---------------- HOME PAGE ----------------
@app.route("/")
def home():
    business_id = request.args.get('business_id')
    registration_success = request.args.get('registration_success') == 'true'
    return render_template("index.html", business_id=business_id, registration_success=registration_success)

# ---------------- DASHBOARD PAGE ----------------
@app.route("/dashboard")
def dashboard():
    if "business_id" not in session:
        return redirect(url_for("home"))

    try:
        business_id = session.get('business_id')
        conn = get_db_connection()
        cur = conn.cursor()
        
        # Get business name
        cur.execute("SELECT business_name FROM businesses WHERE business_id = %s", (business_id,))
        business_name = cur.fetchone()[0]
        
        # Get initial metrics
        cur.execute("""
            SELECT 
                COUNT(*) as total_offers,
                COALESCE(SUM(views), 0) as total_views,
                COALESCE(SUM(engagements), 0) as total_engagements,
                CASE 
                    WHEN COALESCE(SUM(views), 0) > 0 
                    THEN ROUND((COALESCE(SUM(engagements), 0)::numeric / COALESCE(SUM(views), 0)::numeric) * 100, 1)
                    ELSE 0 
                END as conversion_rate
            FROM offers 
            WHERE business_id = %s
        """, (business_id,))
        metrics = cur.fetchone()
        
        cur.close()
        conn.close()
        
        return render_template("dashboard.html",
            business_name=business_name,
            total_offers=metrics[0] if metrics else 0,
            total_views=metrics[1] if metrics else 0,
            total_engagements=metrics[2] if metrics else 0,
            conversion_rate=metrics[3] if metrics else 0
        )
    except Exception as e:
        print(f"Dashboard render error: {str(e)}")
        return render_template("dashboard.html",
            business_name="Business",
            total_offers=0,
            total_views=0,
            total_engagements=0,
            conversion_rate=0
        )

# ---------------- FETCH DASHBOARD DATA ----------------
@app.route("/dashboard-data")
def dashboard_data():
    try:
        business_id = session.get('business_id')
        if not business_id:
            print("No business_id in session")
            return jsonify({"error": "Unauthorized"}), 403

        print(f"Fetching dashboard data for business_id: {business_id}")
        conn = get_db_connection()
        cur = conn.cursor()

        # Get total offers
        cur.execute("""
            SELECT COUNT(*) as total_offers
            FROM offers 
            WHERE business_id = %s
        """, (business_id,))
        total_offers = cur.fetchone()[0] or 0
        print(f"Total offers: {total_offers}")
        
        # Get total views and engagements
        cur.execute("""
            SELECT 
                COALESCE(SUM(views), 0) as total_views,
                COALESCE(SUM(engagements), 0) as total_engagements,
                CASE 
                    WHEN COALESCE(SUM(views), 0) > 0 
                    THEN ROUND((COALESCE(SUM(engagements), 0)::numeric / COALESCE(SUM(views), 0)::numeric) * 100, 1)
                    ELSE 0 
                END as conversion_rate
            FROM offers 
            WHERE business_id = %s
        """, (business_id,))
        metrics = cur.fetchone()
        print(f"Metrics: {metrics}")
        
        # Get recent offers
        cur.execute("""
            SELECT id, title, description, created_at 
            FROM offers 
            WHERE business_id = %s 
            ORDER BY created_at DESC 
            LIMIT 5
        """, (business_id,))
        recent_offers = cur.fetchall()
        print(f"Recent offers count: {len(recent_offers)}")
        
        # Get top performing offers
        cur.execute("""
            SELECT title, views, engagements 
            FROM offers 
            WHERE business_id = %s 
            ORDER BY views DESC 
            LIMIT 3
        """, (business_id,))
        top_offers = cur.fetchall()
        print(f"Top offers count: {len(top_offers)}")

        cur.close()
        conn.close()

        # Generate AI insights
        performance_trend = "Your performance is stable"  # Placeholder
        customer_demographics = "Most customers are between 25-35 years"  # Placeholder
        peak_times = "Peak engagement between 2-4 PM"  # Placeholder
        
        # Generate notifications
        notifications = [
            {
                "type": "info",
                "title": "Welcome Back!",
                "message": "Your dashboard has been updated with the latest data.",
                "time": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            }
        ]
        
        response_data = {
            'total_offers': total_offers,
            'total_views': metrics[0] if metrics else 0,
            'total_engagements': metrics[1] if metrics else 0,
            'conversion_rate': metrics[2] if metrics else 0,
            'performance_trend': performance_trend,
            'customer_demographics': customer_demographics,
            'peak_times': peak_times,
            'recent_offers': [{
                'id': offer[0],
                'title': offer[1],
                'description': offer[2],
                'created_at': offer[3].strftime('%Y-%m-%d %H:%M:%S')
            } for offer in recent_offers],
            'top_offers': [{
                'title': offer[0],
                'views': offer[1] or 0,
                'engagements': offer[2] or 0
            } for offer in top_offers],
            'notifications': notifications
        }
        
        print("Sending response:", response_data)
        return jsonify(response_data)
        
    except Exception as e:
        print(f"Dashboard data error: {str(e)}")
        import traceback
        print("Full traceback:", traceback.format_exc())
        return jsonify({'error': str(e)}), 500

# ---------------- ADD OFFER ----------------
@app.route("/api/offers", methods=["POST"])
def add_offer():
    if "business_id" not in session:
        return jsonify({"message": "Unauthorized"}), 403

    data = request.get_json()
    offer_text = data.get("offer_text")
    if not offer_text:
        return jsonify({"message": "Offer text cannot be empty"}), 400

    business_id = session["business_id"]
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("INSERT INTO offers (business_id, offer_text, created_at) VALUES (%s, %s, %s)",
                (business_id, offer_text, datetime.now()))
    conn.commit()
    cur.close()
    conn.close()

    return jsonify({"message": "Offer added successfully!"}), 200

# ---------------- FETCH ALL OFFERS FOR BUSINESS ----------------
@app.route("/api/offers", methods=["GET"])
def get_offers():
    if "business_id" not in session:
        return jsonify({"message": "Unauthorized"}), 403

    business_id = session["business_id"]
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("""
        SELECT id, title, description, discount, validity, created_at 
        FROM offers 
        WHERE business_id = %s 
        ORDER BY created_at DESC
    """, (business_id,))
    offers = cur.fetchall()
    cur.close()
    conn.close()

    return jsonify([{
        "id": offer[0],
        "title": offer[1],
        "description": offer[2],
        "discount": offer[3],
        "validity": offer[4].strftime("%Y-%m-%d") if offer[4] else None,
        "created_at": offer[5].strftime("%Y-%m-%d %H:%M:%S")
    } for offer in offers])

# ---------------- DELETE OFFER ----------------
@app.route("/delete-offer/<int:offer_id>", methods=["DELETE"])
def remove_offer(offer_id):
    if "business_id" not in session:
        return jsonify({"error": "Unauthorized"}), 403

    try:
        business_id = session["business_id"]
        conn = get_db_connection()
        cur = conn.cursor()

        cur.execute("""
            DELETE FROM offers
            WHERE id = %s AND business_id = %s
            RETURNING id
        """, (offer_id, business_id))
        deleted = cur.fetchone()
        conn.commit()

        if not deleted:
            return jsonify({"error": "Offer not found"}), 404

        return jsonify({"message": "Offer deleted successfully"}), 200

    except Exception as e:
        print(f"Delete offer error: {str(e)}")
        return jsonify({"error": "Failed to delete offer"}), 500
    finally:
        if 'cur' in locals():
            cur.close()
        if 'conn' in locals():
            conn.close()

# ---------------- CREATE OFFER ----------------
@app.route("/create-offer", methods=["POST"])
def create_offer():
    if "business_id" not in session:
        return jsonify({"message": "Unauthorized"}), 403

    try:
        data = request.get_json()
        title = data.get("title")
        description = data.get("description")
        discount = data.get("discount")
        validity = data.get("validity")
        
        if not all([title, description, discount, validity]):
            return jsonify({"message": "All fields are required"}), 400

        business_id = session["business_id"]
        conn = get_db_connection()
        cur = conn.cursor()
        
        cur.execute("""
            INSERT INTO offers (
                business_id, title, description, discount, 
                validity, created_at
            ) VALUES (%s, %s, %s, %s, %s, NOW())
            RETURNING id
        """, (business_id, title, description, discount, validity))
        
        offer_id = cur.fetchone()[0]
        conn.commit()
        cur.close()
        conn.close()

        return jsonify({
            "message": "Offer created successfully!",
            "offer_id": offer_id
        }), 200

    except Exception as e:
        print(f"Create offer error: {str(e)}")
        return jsonify({"message": "Failed to create offer"}), 500

# ---------------- OFFERS PAGE ----------------
@app.route("/offers")
def offers_page():
    if "business_id" not in session:
        return redirect(url_for("home"))
    return render_template("offers.html")

# ---------------- ANALYTICS PAGE ----------------
@app.route("/analytics")
def analytics_page():
    if "business_id" not in session:
        return redirect(url_for("home"))
    return render_template("analytics.html")

# ---------------- ANALYTICS DATA ----------------
@app.route("/analytics-data")
def analytics_data():
    if "business_id" not in session:
        return jsonify({"error": "Unauthorized"}), 403

    try:
        business_id = session.get('business_id')
        days = request.args.get('days', '7', type=int)
        
        conn = get_db_connection()
        cur = conn.cursor()
        
        # Get daily views and engagements
        cur.execute("""
            SELECT 
                DATE(created_at) as date,
                SUM(views) as views,
                SUM(engagements) as engagements
            FROM offers
            WHERE business_id = %s
            AND created_at >= NOW() - INTERVAL '%s days'
            GROUP BY DATE(created_at)
            ORDER BY date
        """, (business_id, days))
        
        daily_data = cur.fetchall()
        
        # Get age group distribution
        cur.execute("""
            SELECT 
                age_group,
                COUNT(*) as count
            FROM customer_engagements
            WHERE business_id = %s
            AND created_at >= NOW() - INTERVAL '%s days'
            GROUP BY age_group
        """, (business_id, days))
        
        age_data = cur.fetchall()
        
        cur.close()
        conn.close()
        
        return jsonify({
            'daily_data': [{
                'date': data[0].strftime('%Y-%m-%d'),
                'views': data[1],
                'engagements': data[2]
            } for data in daily_data],
            'age_data': [{
                'age_group': data[0],
                'count': data[1]
            } for data in age_data]
        })
    except Exception as e:
        print(f"Analytics data error: {str(e)}")
        return jsonify({'error': str(e)}), 500

@app.route("/export-analytics")
def export_analytics():
    if "business_id" not in session:
        return jsonify({"error": "Unauthorized"}), 403

    days = request.args.get("days", "7")
    business_id = session["business_id"]
    conn = get_db_connection()
    cur = conn.cursor()

    try:
        # Get detailed analytics data
        cur.execute("""
            SELECT 
                o.created_at,
                o.title,
                o.description,
                o.discount,
                o.views,
                o.engagements,
                CASE 
                    WHEN o.views > 0 
                    THEN ROUND((o.engagements::float / o.views) * 100, 1)
                    ELSE 0 
                END as conversion_rate
            FROM offers o
            WHERE o.business_id = %s
            AND o.created_at >= NOW() - INTERVAL '%s days'
            ORDER BY o.created_at DESC
        """, (business_id, days))
        data = cur.fetchall()

        # Create CSV content
        csv_content = "Date,Title,Description,Discount,Views,Engagements,Conversion Rate\n"
        for row in data:
            csv_content += f"{row[0].strftime('%Y-%m-%d %H:%M:%S')},{row[1]},{row[2]},{row[3]}%,{row[4]},{row[5]},{row[6]}%\n"

        return Response(
            csv_content,
            mimetype="text/csv",
            headers={"Content-Disposition": f"attachment;filename=analytics_{datetime.now().strftime('%Y%m%d')}.csv"}
        )

    except Exception as e:
        print(f"Export analytics error: {str(e)}")
        return jsonify({"error": "Failed to export analytics data"}), 500
    finally:
        cur.close()
        conn.close()

def generate_ai_insights(metrics, views_data, offers_data, demographics_data, peak_hours_data):
    insights = []

    # Performance insights
    if metrics[2] > 10:  # Conversion rate > 10%
        insights.append("Your offers are performing well with a strong conversion rate. Keep up the good work!")
    elif metrics[2] < 5:  # Conversion rate < 5%
        insights.append("Consider revising your offer strategy to improve conversion rates. Try more targeted promotions.")

    # Views trend insights
    if len(views_data) > 1:
        latest_views = views_data[-1][1]
        previous_views = views_data[-2][1]
        if latest_views > previous_views * 1.2:  # 20% increase
            insights.append("Your views are trending upward! Your recent marketing efforts are paying off.")
        elif latest_views < previous_views * 0.8:  # 20% decrease
            insights.append("Views have decreased recently. Consider boosting your promotional activities.")

    # Peak hours insights
    if peak_hours_data:
        peak_hour = max(peak_hours_data, key=lambda x: x[1])
        insights.append(f"Your business gets most engagement at {int(peak_hour[0]):02d}:00. Consider timing your offers around this hour.")

    # Demographics insights
    if demographics_data:
        top_demo = max(demographics_data, key=lambda x: x[1])
        insights.append(f"Your offers are most popular with the {top_demo[0]} age group. Consider tailoring more content for this demographic.")

    return insights

@app.route('/about')
def about():
    if "business_id" not in session:
        return redirect(url_for("home"))
    return render_template('about.html')

# ---------------- OFFERS DATA ----------------
@app.route("/offers-data")
def offers_data():
    if "business_id" not in session:
        return jsonify({"message": "Unauthorized"}), 403

    try:
        business_id = session.get('business_id')
        conn = get_db_connection()
        cur = conn.cursor()
        
        # Get active offers
        cur.execute("""
            SELECT id, title, description, discount, validity, created_at, views, engagements
            FROM offers 
            WHERE business_id = %s 
            AND (validity IS NULL OR validity >= CURRENT_DATE)
            ORDER BY created_at DESC
        """, (business_id,))
        active_offers = cur.fetchall()
        
        # Get expired offers
        cur.execute("""
            SELECT id, title, description, discount, validity, created_at, views, engagements
            FROM offers 
            WHERE business_id = %s 
            AND validity < CURRENT_DATE
            ORDER BY created_at DESC
        """, (business_id,))
        expired_offers = cur.fetchall()
        
        # Get analytics
        cur.execute("""
            SELECT 
                SUM(views) as total_views,
                SUM(engagements) as total_engagements,
                CASE 
                    WHEN SUM(views) > 0 
                    THEN ROUND((SUM(engagements)::numeric / SUM(views)::numeric) * 100, 1)
                    ELSE 0 
                END as conversion_rate
            FROM offers 
            WHERE business_id = %s
        """, (business_id,))
        analytics = cur.fetchone()
        
        cur.close()
        conn.close()
        
        return jsonify({
            'active_offers': [{
                'id': offer[0],
                'title': offer[1],
                'description': offer[2],
                'discount': offer[3],
                'validity': offer[4].strftime('%Y-%m-%d') if offer[4] else None,
                'created_at': offer[5].strftime('%Y-%m-%d %H:%M:%S'),
                'views': offer[6],
                'engagements': offer[7]
            } for offer in active_offers],
            'expired_offers': [{
                'id': offer[0],
                'title': offer[1],
                'description': offer[2],
                'discount': offer[3],
                'validity': offer[4].strftime('%Y-%m-%d') if offer[4] else None,
                'created_at': offer[5].strftime('%Y-%m-%d %H:%M:%S'),
                'views': offer[6],
                'engagements': offer[7]
            } for offer in expired_offers],
            'analytics': {
                'total_views': analytics[0] or 0,
                'total_engagements': analytics[1] or 0,
                'conversion_rate': analytics[2] or 0
            }
        })
    except Exception as e:
        print(f"Offers data error: {str(e)}")
        return jsonify({'error': str(e)}), 500

# ---------------- SETTINGS PAGE ----------------
@app.route("/settings")
def settings_page():
    if "business_id" not in session:
        return redirect(url_for("home"))
    return render_template("settings.html")

# ---------------- SETTINGS API ----------------
@app.route("/api/settings", methods=["GET"])
def get_settings():
    if "business_id" not in session:
        return jsonify({"message": "Unauthorized"}), 403

    try:
        business_id = session.get('business_id')
        conn = get_db_connection()
        cur = conn.cursor()
        
        # Get business profile
        cur.execute("""
            SELECT business_name, email, phone, address, 
                   email_notifications, offer_updates, analytics_reports
            FROM businesses 
            WHERE business_id = %s
        """, (business_id,))
        business = cur.fetchone()
        
        cur.close()
        conn.close()
        
        if business:
            return jsonify({
                'business_name': business[0],
                'email': business[1],
                'phone': business[2],
                'address': business[3],
                'email_notifications': business[4],
                'offer_updates': business[5],
                'analytics_reports': business[6]
            })
        else:
            return jsonify({"message": "Business not found"}), 404
            
    except Exception as e:
        print(f"Get settings error: {str(e)}")
        return jsonify({'error': str(e)}), 500

@app.route("/api/settings/profile", methods=["PUT"])
def update_profile():
    if "business_id" not in session:
        return jsonify({"message": "Unauthorized"}), 403

    try:
        data = request.get_json()
        business_id = session.get('business_id')
        
        conn = get_db_connection()
        cur = conn.cursor()
        
        cur.execute("""
            UPDATE businesses 
            SET business_name = %s, email = %s, phone = %s, address = %s
            WHERE business_id = %s
        """, (
            data.get('business_name'),
            data.get('email'),
            data.get('phone'),
            data.get('address'),
            business_id
        ))
        
        conn.commit()
        cur.close()
        conn.close()
        
        return jsonify({"message": "Profile updated successfully"})
        
    except Exception as e:
        print(f"Update profile error: {str(e)}")
        return jsonify({'error': str(e)}), 500

@app.route("/api/settings/password", methods=["PUT"])
def update_password():
    if "business_id" not in session:
        return jsonify({"message": "Unauthorized"}), 403

    try:
        data = request.get_json()
        business_id = session.get('business_id')
        current_password = data.get('current_password')
        new_password = data.get('new_password')
        
        conn = get_db_connection()
        cur = conn.cursor()
        
        # Verify current password
        cur.execute("SELECT password FROM businesses WHERE business_id = %s", (business_id,))
        stored_password = cur.fetchone()[0]
        
        if not check_password_hash(stored_password, current_password):
            return jsonify({"message": "Current password is incorrect"}), 400
        
        # Update password
        hashed_password = generate_password_hash(new_password)
        cur.execute("""
            UPDATE businesses 
            SET password = %s
            WHERE business_id = %s
        """, (hashed_password, business_id))
        
        conn.commit()
        cur.close()
        conn.close()
        
        return jsonify({"message": "Password updated successfully"})
        
    except Exception as e:
        print(f"Update password error: {str(e)}")
        return jsonify({'error': str(e)}), 500

@app.route("/api/settings/notifications", methods=["PUT"])
def update_notifications():
    if "business_id" not in session:
        return jsonify({"message": "Unauthorized"}), 403

    try:
        data = request.get_json()
        business_id = session.get('business_id')
        
        conn = get_db_connection()
        cur = conn.cursor()
        
        cur.execute("""
            UPDATE businesses 
            SET email_notifications = %s, 
                offer_updates = %s, 
                analytics_reports = %s
            WHERE business_id = %s
        """, (
            data.get('email_notifications', False),
            data.get('offer_updates', False),
            data.get('analytics_reports', False),
            business_id
        ))
        
        conn.commit()
        cur.close()
        conn.close()

        return jsonify({"message": "Notification preferences updated successfully"})
        
    except Exception as e:
        print(f"Update notifications error: {str(e)}")
        return jsonify({'error': str(e)}), 500

# ---------------- CUSTOMER API ENDPOINTS ----------------
@app.route("/api/businesses/nearby", methods=["GET"])
def get_nearby_businesses():
    try:
        latitude = float(request.args.get('latitude', 0))
        longitude = float(request.args.get('longitude', 0))
        radius = float(request.args.get('radius', 5.0))  # Default 5km radius

        conn = get_db_connection()
        cur = conn.cursor()
        
        # For now, we'll return all businesses since we don't have actual coordinates
        cur.execute("""
            SELECT 
                business_id,
                business_name,
                category,
                location,
                address,
                email,
                phone
            FROM businesses
            LIMIT 20
        """)
        
        businesses = []
        for row in cur.fetchall():
            business = {
                'id': row[0],
                'name': row[1],
                'category': row[2],
                'location': row[3],
                'address': row[4],
                'email': row[5],
                'phone': row[6],
                'distance': round(random.uniform(0.1, radius), 1),
                'rating': round(random.uniform(3.5, 5.0), 1),  # Simulated rating
                'reviews_count': random.randint(10, 100),  # Simulated review count
                'image_url': f'https://picsum.photos/seed/{row[0]}/300/200'  # Random image for each business
            }
            businesses.append(business)
        
        cur.close()
        conn.close()
        
        return jsonify(businesses), 200
        
    except Exception as e:
        print(f"Error fetching nearby businesses: {str(e)}")
        return jsonify({"error": str(e)}), 500

@app.route("/api/auth/register", methods=["POST"])
def customer_register():
    try:
        data = request.get_json()
        print("Received customer registration data:", data)
        
        username = data.get("username")
        email = data.get("email")
        password = data.get("password")
        phone = data.get("phone")
        preferences = data.get("preferences", [])

        if not all([username, email, password]):
            return jsonify({"error": "Username, email, and password are required"}), 400

        conn = get_db_connection()
        cur = conn.cursor()

        # Check if email already exists
        cur.execute("SELECT 1 FROM users WHERE email = %s", (email,))
        if cur.fetchone():
            cur.close()
            conn.close()
            return jsonify({"error": "Email already registered"}), 400

        # Generate user_id
        cur.execute("SELECT COUNT(*) FROM users")
        count = cur.fetchone()[0]
        user_id = f"u{count + 1}"

        # Use pbkdf2:sha256 instead of scrypt
        hashed_password = generate_password_hash(password, method='pbkdf2:sha256')

        # Insert user
        cur.execute("""
            INSERT INTO users (user_id, username, email, password, phone)
            VALUES (%s, %s, %s, %s, %s)
            RETURNING id
        """, (user_id, username, email, hashed_password, phone))
        
        user_db_id = cur.fetchone()[0]

        # Insert user preferences
        for preference in preferences:
            cur.execute("""
                INSERT INTO user_preferences (user_id, preference_id)
                SELECT %s, id FROM preferences WHERE preference_name = %s
            """, (user_id, preference))

        conn.commit()
        cur.close()
        conn.close()

        return jsonify({
            "message": "Registration successful",
            "user": {
                "id": user_id,
                "username": username,
                "email": email,
                "phone": phone,
                "preferences": preferences
            }
        }), 200

    except Exception as e:
        print(f"Customer registration error: {str(e)}")
        return jsonify({"error": str(e)}), 500

@app.route("/api/auth/login", methods=["POST"])
def customer_login():
    try:
        data = request.get_json()
        print("Received customer login data:", data)
        
        email = data.get("email")
        password = data.get("password")

        if not all([email, password]):
            return jsonify({"error": "Email and password are required"}), 400

        conn = get_db_connection()
        cur = conn.cursor()

        # Check if user exists and verify password
        cur.execute("SELECT user_id, username, email, password, phone FROM users WHERE email = %s", (email,))
        user_data = cur.fetchone()

        if not user_data or not check_password_hash(user_data[3], password):
            cur.close()
            conn.close()
            return jsonify({"error": "Invalid email or password"}), 401

        # Get user preferences
        cur.execute("""
            SELECT p.preference_name 
            FROM preferences p 
            JOIN user_preferences up ON p.id = up.preference_id 
            WHERE up.user_id = %s
        """, (user_data[0],))
        preferences = [row[0] for row in cur.fetchall()]

        cur.close()
        conn.close()

        # Create response with user data
        user = {
            "id": user_data[0],
            "username": user_data[1],
            "email": user_data[2],
            "phone": user_data[4],
            "preferences": preferences
        }

        return jsonify({
            "message": "Login successful",
            "user": user
        }), 200

    except Exception as e:
        print(f"Customer login error: {str(e)}")
        return jsonify({"error": str(e)}), 500

@app.route("/api/recommendations", methods=["GET"])
def get_recommendations():
    try:
        user_id = request.args.get('user_id')
        latitude = float(request.args.get('latitude', 0))
        longitude = float(request.args.get('longitude', 0))
        
        if not user_id:
            return jsonify({"error": "User ID is required"}), 400

        conn = get_db_connection()
        cur = conn.cursor()
        
        # Get user preferences
        cur.execute("""
            SELECT p.preference_name 
            FROM preferences p 
            JOIN user_preferences up ON p.id = up.preference_id 
            WHERE up.user_id = %s
        """, (user_id,))
        user_preferences = [row[0] for row in cur.fetchall()]
        
        # Get user's recent activity
        cur.execute("""
            SELECT DISTINCT b.category, MAX(ua.created_at) as last_activity
            FROM user_activity ua 
            JOIN businesses b ON ua.business_id = b.business_id 
            WHERE ua.user_id = %s 
            GROUP BY b.category
            ORDER BY last_activity DESC 
            LIMIT 5
        """, (user_id,))
        recent_categories = [row[0] for row in cur.fetchall()]
        
        # Get popular businesses based on views and engagements
        cur.execute("""
            SELECT 
                b.business_id,
                b.business_name,
                b.category,
                b.location,
                b.address,
                b.email,
                b.phone,
                COALESCE(SUM(o.views), 0) as total_views,
                COALESCE(SUM(o.engagements), 0) as total_engagements
            FROM businesses b 
            LEFT JOIN offers o ON b.business_id = o.business_id
            GROUP BY b.business_id, b.business_name, b.category, b.location, b.address, b.email, b.phone
            ORDER BY 
                CASE WHEN b.category = ANY(%s) THEN 0 ELSE 1 END,
                total_engagements DESC, 
                total_views DESC
            LIMIT 10
        """, (recent_categories + user_preferences,))
        
        recommended_businesses = []
        for row in cur.fetchall():
            business = {
                'id': row[0],
                'name': row[1],
                'category': row[2],
                'location': row[3],
                'address': row[4],
                'email': row[5],
                'phone': row[6],
                'description': f'Popular {row[2]} in {row[3]}',
                'distance': round(random.uniform(0.1, 5.0), 1),  # Simulated distance
                'rating': round(random.uniform(4.0, 5.0), 1),  # Simulated rating
                'reviews_count': random.randint(50, 200),  # Simulated review count
                'image_url': f'https://picsum.photos/seed/{row[0]}/300/200',  # Random image
                'engagement_score': row[8],  # Number of engagements
                'view_count': row[7],  # Number of views
            }
            recommended_businesses.append(business)
        
        # Get similar users' preferred businesses
        cur.execute("""
            WITH similar_users AS (
                SELECT DISTINCT up1.user_id
                FROM user_preferences up1
                JOIN user_preferences up2 ON up1.preference_id = up2.preference_id
                WHERE up2.user_id = %s AND up1.user_id != %s
            )
            SELECT DISTINCT 
                b.business_id,
                b.business_name,
                b.category,
                b.location,
                b.address,
                b.email,
                b.phone
            FROM user_activity ua
            JOIN businesses b ON ua.business_id = b.business_id
            WHERE ua.user_id IN (SELECT user_id FROM similar_users)
            AND ua.activity_type = 'favorite'
            LIMIT 5
        """, (user_id, user_id))
        
        for row in cur.fetchall():
            business = {
                'id': row[0],
                'name': row[1],
                'category': row[2],
                'location': row[3],
                'address': row[4],
                'email': row[5],
                'phone': row[6],
                'description': f'Recommended based on similar users who like {row[2]} businesses',
                'distance': round(random.uniform(0.1, 5.0), 1),
                'rating': round(random.uniform(4.0, 5.0), 1),
                'reviews_count': random.randint(50, 200),
                'image_url': f'https://picsum.photos/seed/{row[0]}/300/200',
            }
            recommended_businesses.append(business)
        
        cur.close()
        conn.close()
        
        return jsonify(recommended_businesses), 200
        
    except Exception as e:
        print(f"Error getting recommendations: {str(e)}")
        return jsonify({"error": str(e)}), 500

@app.route("/api/business/<business_id>/offers", methods=["GET"])
def get_business_offers(business_id):
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        
        # Get business details first
        cur.execute("""
            SELECT business_name, category, location 
            FROM businesses 
            WHERE business_id = %s
        """, (business_id,))
        business = cur.fetchone()
        
        if not business:
            return jsonify({"error": "Business not found"}), 404
            
        # Get active offers for the business
        cur.execute("""
            SELECT id, title, description, discount, validity, created_at, views, engagements
            FROM offers 
            WHERE business_id = %s 
            AND (validity IS NULL OR validity >= CURRENT_DATE)
            ORDER BY created_at DESC
        """, (business_id,))
        offers = cur.fetchall()
        
        cur.close()
        conn.close()
        
        if not offers:
            return jsonify({
                "business": {
                    "name": business[0],
                    "category": business[1],
                    "location": business[2]
                },
                "offers": [],
                "message": "No current offers available"
            }), 200
            
        return jsonify({
            "business": {
                "name": business[0],
                "category": business[1],
                "location": business[2]
            },
            "offers": [{
                'id': offer[0],
                'title': offer[1],
                'description': offer[2],
                'discount': offer[3],
                'validity': offer[4].strftime('%Y-%m-%d') if offer[4] else None,
                'created_at': offer[5].strftime('%Y-%m-%d %H:%M:%S'),
                'views': offer[6] or 0,
                'engagements': offer[7] or 0
            } for offer in offers]
        }), 200
        
    except Exception as e:
        print(f"Error fetching business offers: {str(e)}")
        return jsonify({"error": str(e)}), 500

@app.route("/api/offers/recommended", methods=["GET"])
def get_recommended_offers():
    try:
        user_id = request.args.get('user_id')
        if not user_id:
            return jsonify({"error": "User ID is required"}), 400
            
        conn = get_db_connection()
        cur = conn.cursor()
        
        # Get user preferences
        cur.execute("""
            SELECT p.preference_name 
            FROM preferences p 
            JOIN user_preferences up ON p.id = up.preference_id 
            WHERE up.user_id = %s
        """, (user_id,))
        preferences = [row[0] for row in cur.fetchall()]
        
        # Get recommended offers based on user preferences and business categories
        cur.execute("""
            SELECT 
                o.id,
                o.title,
                o.description,
                o.discount,
                o.validity,
                o.created_at,
                o.views,
                o.engagements,
                b.business_id,
                b.business_name,
                b.category,
                b.location
            FROM offers o
            JOIN businesses b ON o.business_id = b.business_id
            WHERE b.category = ANY(%s)
            AND (o.validity IS NULL OR o.validity >= CURRENT_DATE)
            ORDER BY o.created_at DESC
            LIMIT 20
        """, (preferences,))
        
        offers = cur.fetchall()
        cur.close()
        conn.close()
        
        if not offers:
            return jsonify({
                "offers": [],
                "message": "No recommended offers available"
            }), 200
            
        return jsonify({
            "offers": [{
                'id': offer[0],
                'title': offer[1],
                'description': offer[2],
                'discount': offer[3],
                'validity': offer[4].strftime('%Y-%m-%d') if offer[4] else None,
                'created_at': offer[5].strftime('%Y-%m-%d %H:%M:%S'),
                'views': offer[6] or 0,
                'engagements': offer[7] or 0,
                'business': {
                    'id': offer[8],
                    'name': offer[9],
                    'category': offer[10],
                    'location': offer[11]
                }
            } for offer in offers]
        }), 200
        
    except Exception as e:
        print(f"Error fetching recommended offers: {str(e)}")
        return jsonify({"error": str(e)}), 500

# ---------------- START SERVER ----------------
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3000, debug=True)
