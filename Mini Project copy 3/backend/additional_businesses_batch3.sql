-- Insert final batch of businesses
DO $$
BEGIN
    -- More Restaurants
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b226') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b226', 'Curry Leaf', 'restaurant', 'Pattom', 'Medical College Road', 'curry.leaf@example.com', '+91-9876543326', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b227') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b227', 'Seafood Kitchen', 'restaurant', 'Kovalam', 'Lighthouse Beach', 'seafood.kitchen@example.com', '+91-9876543327', 'dummy_password');
    END IF;

    -- More Cafes
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b228') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b228', 'Coffee Stories', 'cafe', 'Technopark', 'Phase 3', 'coffee.stories@example.com', '+91-9876543328', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b229') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b229', 'Tea Room', 'cafe', 'MG Road', 'Shopping Mall', 'tea.room@example.com', '+91-9876543329', 'dummy_password');
    END IF;

    -- More Traditional Shops
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b230') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b230', 'Mundu World', 'clothing', 'East Fort', 'Temple Square', 'mundu.world@example.com', '+91-9876543330', 'dummy_password');
    END IF;

    -- More Healthcare
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b231') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b231', 'Ayur Life', 'healthcare', 'Vanchiyoor', 'Hospital Road', 'ayur.life@example.com', '+91-9876543331', 'dummy_password');
    END IF;

    -- More Entertainment
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b232') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b232', 'Music Hub', 'entertainment', 'Palayam', 'Arts Centre', 'music.hub@example.com', '+91-9876543332', 'dummy_password');
    END IF;

    -- Specialty Stores
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b233') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b233', 'Spice World', 'grocery', 'Chalai', 'Market Road', 'spice.world@example.com', '+91-9876543333', 'dummy_password');
    END IF;
END $$;

-- Add offers for the final batch
DO $$
BEGIN
    -- Restaurant offers
    IF NOT EXISTS (SELECT 1 FROM offers WHERE business_id = 'b226' AND title = 'Lunch Bonanza') THEN
        INSERT INTO offers (business_id, title, description, discount, validity, views, engagements)
        VALUES ('b226', 'Lunch Bonanza', 'Special thali meals', 20, CURRENT_DATE + INTERVAL '30 days', 160, 65);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM offers WHERE business_id = 'b227' AND title = 'Beach Special') THEN
        INSERT INTO offers (business_id, title, description, discount, validity, views, engagements)
        VALUES ('b227', 'Beach Special', 'Fresh seafood platter', 25, CURRENT_DATE + INTERVAL '15 days', 200, 80);
    END IF;

    -- Cafe offers
    IF NOT EXISTS (SELECT 1 FROM offers WHERE business_id = 'b228' AND title = 'Coffee & Code') THEN
        INSERT INTO offers (business_id, title, description, discount, validity, views, engagements)
        VALUES ('b228', 'Coffee & Code', 'Tech community special', 15, CURRENT_DATE + INTERVAL '30 days', 180, 70);
    END IF;
END $$;

-- Add more user activity data
DO $$
BEGIN
    -- Add activities for user u3 (restaurant and entertainment preferences)
    IF EXISTS (SELECT 1 FROM users WHERE user_id = 'u3') THEN
        -- View Curry Leaf
        IF NOT EXISTS (SELECT 1 FROM user_activity WHERE user_id = 'u3' AND business_id = 'b226' AND activity_type = 'view') THEN
            INSERT INTO user_activity (user_id, business_id, activity_type, created_at)
            VALUES ('u3', 'b226', 'view', CURRENT_TIMESTAMP - INTERVAL '3 hours');
        END IF;

        -- Favorite Music Hub
        IF NOT EXISTS (SELECT 1 FROM user_activity WHERE user_id = 'u3' AND business_id = 'b232' AND activity_type = 'favorite') THEN
            INSERT INTO user_activity (user_id, business_id, activity_type, created_at)
            VALUES ('u3', 'b232', 'favorite', CURRENT_TIMESTAMP - INTERVAL '1 day');
        END IF;
    END IF;
END $$; 