-- Insert 50 more businesses with Kerala-themed names and locations
DO $$
BEGIN
    -- Restaurants & Food (15 businesses)
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b200') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b200', 'Paragon Express', 'restaurant', 'Technopark', 'Phase 3, Technopark', 'paragon.express@example.com', '+91-9876543300', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b201') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b201', 'Kerala Kitchen', 'restaurant', 'Pattom', 'Near Pattom Church', 'kerala.kitchen@example.com', '+91-9876543301', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b202') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b202', 'Kappa Chakka Kandhari', 'restaurant', 'MG Road', 'MG Road Junction', 'kck@example.com', '+91-9876543302', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b203') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b203', 'Fish Market Kitchen', 'restaurant', 'Chalai', 'Near Fish Market', 'fish.market@example.com', '+91-9876543303', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b204') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b204', 'Thattukada Junction', 'restaurant', 'East Fort', 'Near KSRTC Stand', 'thattukada@example.com', '+91-9876543304', 'dummy_password');
    END IF;

    -- Cafes & Tea Shops (10 businesses)
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b205') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b205', 'Student Cafe', 'cafe', 'Palayam', 'Near University', 'student.cafe@example.com', '+91-9876543305', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b206') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b206', 'Tea Tales', 'cafe', 'Vanchiyoor', 'Court Junction', 'tea.tales@example.com', '+91-9876543306', 'dummy_password');
    END IF;

    -- Traditional Clothing & Textiles (8 businesses)
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b207') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b207', 'Handloom Heritage', 'clothing', 'Chalai', 'Main Bazaar', 'handloom.heritage@example.com', '+91-9876543307', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b208') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b208', 'Silk Stories', 'clothing', 'MG Road', 'Shopping Complex', 'silk.stories@example.com', '+91-9876543308', 'dummy_password');
    END IF;

    -- Wellness & Healthcare (7 businesses)
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b209') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b209', 'Healing Hands Ayurveda', 'healthcare', 'Vanchiyoor', 'Medical College Road', 'healing.hands@example.com', '+91-9876543309', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b210') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b210', 'Wellness Paradise', 'spa', 'Kovalam', 'Beach Resort Area', 'wellness.paradise@example.com', '+91-9876543310', 'dummy_password');
    END IF;

    -- Entertainment & Culture (5 businesses)
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b211') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b211', 'Cultural Hub', 'entertainment', 'Vellayambalam', 'Museum Road', 'cultural.hub@example.com', '+91-9876543311', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b212') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b212', 'Art House', 'art_gallery', 'Thampanoor', 'Station View Road', 'art.house@example.com', '+91-9876543312', 'dummy_password');
    END IF;

    -- Modern Services (5 businesses)
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b213') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b213', 'Digital Hub', 'coworking', 'Technopark', 'Phase 1', 'digital.hub@example.com', '+91-9876543313', 'dummy_password');
    END IF;

    -- And continue with more businesses...
    -- Adding offers for new businesses
    IF NOT EXISTS (SELECT 1 FROM offers WHERE business_id = 'b200' AND title = 'Weekend Special') THEN
        INSERT INTO offers (business_id, title, description, discount, validity, views, engagements)
        VALUES ('b200', 'Weekend Special', 'Special Kerala meals', 15, CURRENT_DATE + INTERVAL '30 days', 100, 40);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM offers WHERE business_id = 'b207' AND title = 'Onam Collection') THEN
        INSERT INTO offers (business_id, title, description, discount, validity, views, engagements)
        VALUES ('b207', 'Onam Collection', 'Festival special collection', 25, CURRENT_DATE + INTERVAL '45 days', 150, 60);
    END IF;

    -- Add some initial activity data
    IF EXISTS (SELECT 1 FROM users WHERE user_id = 'u1') THEN
        IF NOT EXISTS (SELECT 1 FROM user_activity WHERE user_id = 'u1' AND business_id = 'b200' AND activity_type = 'view') THEN
            INSERT INTO user_activity (user_id, business_id, activity_type, created_at)
            VALUES ('u1', 'b200', 'view', CURRENT_TIMESTAMP - INTERVAL '1 day');
        END IF;
    END IF;
END $$;

-- Continue with more businesses in a second batch
DO $$
BEGIN
    -- More Restaurants
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b214') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b214', 'Banana Leaf', 'restaurant', 'Peroorkada', 'Junction Road', 'banana.leaf@example.com', '+91-9876543314', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b215') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b215', 'Spice Garden', 'restaurant', 'Sasthamangalam', 'Main Road', 'spice.garden@example.com', '+91-9876543315', 'dummy_password');
    END IF;

    -- More Cafes
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b216') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b216', 'Book & Brew', 'cafe', 'Vazhuthacaud', 'Near All Saints', 'book.brew@example.com', '+91-9876543316', 'dummy_password');
    END IF;

    -- More Traditional Shops
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b217') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b217', 'Spice Route', 'grocery', 'Chalai', 'Spice Market', 'spice.route@example.com', '+91-9876543317', 'dummy_password');
    END IF;

    -- Continue adding more businesses...
END $$;

-- Add offers for the second batch
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM offers WHERE business_id = 'b214' AND title = 'Lunch Special') THEN
        INSERT INTO offers (business_id, title, description, discount, validity, views, engagements)
        VALUES ('b214', 'Lunch Special', 'Traditional Kerala meals', 20, CURRENT_DATE + INTERVAL '15 days', 120, 50);
    END IF;
END $$; 