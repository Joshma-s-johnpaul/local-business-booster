CREATE TABLE businesses (
    id SERIAL PRIMARY KEY,
    business_id VARCHAR(20) UNIQUE NOT NULL,
    business_name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
    password TEXT NOT NULL,
    email_notifications BOOLEAN DEFAULT true,
    offer_updates BOOLEAN DEFAULT true,
    analytics_reports BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE offers (
    id SERIAL PRIMARY KEY,
    business_id VARCHAR(20) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    discount INTEGER NOT NULL,
    validity DATE NOT NULL,
    terms TEXT,
    views INTEGER DEFAULT 0,
    engagements INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (business_id) REFERENCES businesses (business_id) ON DELETE CASCADE
);

CREATE TABLE customer_engagements (
    id SERIAL PRIMARY KEY,
    business_id VARCHAR(20) NOT NULL,
    offer_id INTEGER NOT NULL,
    age_group VARCHAR(20),
    engagement_type VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (business_id) REFERENCES businesses (business_id) ON DELETE CASCADE,
    FOREIGN KEY (offer_id) REFERENCES offers (id) ON DELETE CASCADE
);

-- Add new columns to businesses table
ALTER TABLE businesses
ADD COLUMN IF NOT EXISTS email VARCHAR(255),
ADD COLUMN IF NOT EXISTS phone VARCHAR(20),
ADD COLUMN IF NOT EXISTS email_notifications BOOLEAN DEFAULT true,
ADD COLUMN IF NOT EXISTS offer_updates BOOLEAN DEFAULT true,
ADD COLUMN IF NOT EXISTS analytics_reports BOOLEAN DEFAULT true;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(50) UNIQUE NOT NULL,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create preferences table
CREATE TABLE IF NOT EXISTS preferences (
    id SERIAL PRIMARY KEY,
    preference_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT
);

-- Create user_preferences table (many-to-many relationship)
CREATE TABLE IF NOT EXISTS user_preferences (
    user_id VARCHAR(50) REFERENCES users(user_id),
    preference_id INTEGER REFERENCES preferences(id),
    PRIMARY KEY (user_id, preference_id)
);

-- Create user_locations table
CREATE TABLE IF NOT EXISTS user_locations (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(50) REFERENCES users(user_id),
    location_name VARCHAR(50) NOT NULL,
    is_primary BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create user_activity table (for tracking user interactions)
CREATE TABLE IF NOT EXISTS user_activity (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(50) REFERENCES users(user_id),
    business_id VARCHAR(50) REFERENCES businesses(business_id),
    activity_type VARCHAR(50) NOT NULL, -- 'view', 'favorite', 'review'
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default preferences
INSERT INTO preferences (preference_name, description) VALUES
('vegetarian', 'Vegetarian food preferences'),
('non_vegetarian', 'Non-vegetarian food preferences'),
('vegan', 'Vegan food preferences'),
('organic', 'Organic and natural products'),
('traditional', 'Traditional Kerala products and services'),
('modern', 'Modern and contemporary offerings'),
('budget', 'Budget-friendly options'),
('premium', 'Premium and luxury options'),
('family', 'Family-friendly establishments'),
('student', 'Student-friendly options'),
('health_conscious', 'Health and wellness focused'),
('cultural', 'Cultural and heritage interests'),
('entertainment', 'Entertainment and leisure activities'),
('shopping', 'Shopping and retail preferences'),
('food', 'Food and dining preferences'),
('wellness', 'Wellness and self-care preferences'),
('education', 'Educational and learning preferences'),
('technology', 'Technology and gadgets preferences'),
('fashion', 'Fashion and style preferences'),
('art', 'Art and creative preferences'); 