-- Insert remaining businesses to reach 50 total
DO $$
BEGIN
    -- More Restaurants & Food
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b218') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b218', 'Porotta Paradise', 'restaurant', 'Palayam', 'Market Road', 'porotta.paradise@example.com', '+91-9876543318', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b219') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b219', 'Fish Harbor', 'restaurant', 'Kovalam', 'Beach Road', 'fish.harbor@example.com', '+91-9876543319', 'dummy_password');
    END IF;

    -- Traditional Sweet Shops
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b220') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b220', 'Sweet Symphony', 'restaurant', 'East Fort', 'Temple Road', 'sweet.symphony@example.com', '+91-9876543320', 'dummy_password');
    END IF;

    -- More Cafes
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b221') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b221', 'Hill Brew', 'cafe', 'Vellayambalam', 'Museum Road', 'hill.brew@example.com', '+91-9876543321', 'dummy_password');
    END IF;

    -- Specialty Stores
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b222') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b222', 'Kerala Crafts', 'handicrafts', 'MG Road', 'Shopping Complex', 'kerala.crafts@example.com', '+91-9876543322', 'dummy_password');
    END IF;

    -- More Healthcare
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b223') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b223', 'Mind & Body Wellness', 'healthcare', 'Pattom', 'Medical Centre', 'mind.body@example.com', '+91-9876543323', 'dummy_password');
    END IF;

    -- Entertainment
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b224') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b224', 'Cinema Paradise', 'entertainment', 'Thampanoor', 'Central Mall', 'cinema.paradise@example.com', '+91-9876543324', 'dummy_password');
    END IF;

    -- Modern Services
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b225') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b225', 'Tech Space', 'coworking', 'Technopark', 'Phase 2', 'tech.space@example.com', '+91-9876543325', 'dummy_password');
    END IF;

    -- Add more businesses to reach 50...
END $$;

-- Add offers for new businesses
DO $$
BEGIN
    -- Restaurant offers
    IF NOT EXISTS (SELECT 1 FROM offers WHERE business_id = 'b218' AND title = 'Porotta Fest') THEN
        INSERT INTO offers (business_id, title, description, discount, validity, views, engagements)
        VALUES ('b218', 'Porotta Fest', 'Unlimited porotta and curry', 25, CURRENT_DATE + INTERVAL '30 days', 180, 75);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM offers WHERE business_id = 'b219' AND title = 'Seafood Special') THEN
        INSERT INTO offers (business_id, title, description, discount, validity, views, engagements)
        VALUES ('b219', 'Seafood Special', 'Fresh catch of the day', 20, CURRENT_DATE + INTERVAL '15 days', 150, 60);
    END IF;

    -- Healthcare offers
    IF NOT EXISTS (SELECT 1 FROM offers WHERE business_id = 'b223' AND title = 'Wellness Package') THEN
        INSERT INTO offers (business_id, title, description, discount, validity, views, engagements)
        VALUES ('b223', 'Wellness Package', 'Complete health checkup', 30, CURRENT_DATE + INTERVAL '45 days', 120, 40);
    END IF;
END $$;

-- Add user activity data
DO $$
BEGIN
    -- Add activities for user u1
    IF EXISTS (SELECT 1 FROM users WHERE user_id = 'u1') THEN
        -- View Porotta Paradise
        IF NOT EXISTS (SELECT 1 FROM user_activity WHERE user_id = 'u1' AND business_id = 'b218' AND activity_type = 'view') THEN
            INSERT INTO user_activity (user_id, business_id, activity_type, created_at)
            VALUES ('u1', 'b218', 'view', CURRENT_TIMESTAMP - INTERVAL '12 hours');
        END IF;

        -- Favorite Fish Harbor
        IF NOT EXISTS (SELECT 1 FROM user_activity WHERE user_id = 'u1' AND business_id = 'b219' AND activity_type = 'favorite') THEN
            INSERT INTO user_activity (user_id, business_id, activity_type, created_at)
            VALUES ('u1', 'b219', 'favorite', CURRENT_TIMESTAMP - INTERVAL '1 day');
        END IF;
    END IF;

    -- Add activities for user u2 (healthcare preferences)
    IF EXISTS (SELECT 1 FROM users WHERE user_id = 'u2') THEN
        -- View Mind & Body Wellness
        IF NOT EXISTS (SELECT 1 FROM user_activity WHERE user_id = 'u2' AND business_id = 'b223' AND activity_type = 'view') THEN
            INSERT INTO user_activity (user_id, business_id, activity_type, created_at)
            VALUES ('u2', 'b223', 'view', CURRENT_TIMESTAMP - INTERVAL '6 hours');
        END IF;
    END IF;
END $$; 