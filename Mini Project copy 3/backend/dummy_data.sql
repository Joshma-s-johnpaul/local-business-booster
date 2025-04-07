-- Insert dummy businesses with Kerala-themed names and locations if they don't exist
DO $$
BEGIN
    -- Restaurants & Food
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b100') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b100', 'Malabar Kitchen', 'restaurant', 'Palayam', 'Near Palayam Market', 'malabar.kitchen@example.com', '+91-9876543210', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b101') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b101', 'Kerala Cafe', 'cafe', 'Technopark', 'Phase 1, Technopark Campus', 'kerala.cafe@example.com', '+91-9876543211', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b102') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b102', 'Thalassery Biriyani House', 'restaurant', 'Pattom', 'Pattom Junction', 'thalassery.biriyani@example.com', '+91-9876543212', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b103') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b103', 'Chaayakkada', 'cafe', 'East Fort', 'Near East Fort Bus Stand', 'chaayakkada@example.com', '+91-9876543213', 'dummy_password');
    END IF;

    -- Traditional & Clothing
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b104') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b104', 'Kasavu World', 'clothing', 'MG Road', 'MG Road Shopping Complex', 'kasavu.world@example.com', '+91-9876543214', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b105') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b105', 'Kerala Handloom Hub', 'clothing', 'Chalai', 'Chalai Market', 'handloom.hub@example.com', '+91-9876543215', 'dummy_password');
    END IF;

    -- Wellness & Healthcare
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b106') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b106', 'Ayur Wellness', 'healthcare', 'Vanchiyoor', 'Near District Court', 'ayur.wellness@example.com', '+91-9876543216', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b107') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b107', 'Kerala Massage Center', 'spa', 'Kovalam', 'Beach Road', 'kerala.massage@example.com', '+91-9876543217', 'dummy_password');
    END IF;

    -- Entertainment & Culture
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b108') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b108', 'Kathakali Cultural Centre', 'entertainment', 'Vellayambalam', 'Near Museum', 'kathakali.centre@example.com', '+91-9876543218', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b109') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b109', 'Kerala Arts Gallery', 'art_gallery', 'Thampanoor', 'Near Central Station', 'kerala.arts@example.com', '+91-9876543219', 'dummy_password');
    END IF;

    -- Food Specialties
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b110') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b110', 'Toddy Shop Experience', 'restaurant', 'Varkala', 'Cliff Road', 'toddy.shop@example.com', '+91-9876543220', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b111') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b111', 'Meen Curry House', 'restaurant', 'Peroorkada', 'Main Road', 'meen.curry@example.com', '+91-9876543221', 'dummy_password');
    END IF;

    -- Modern Cafes
    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b112') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b112', 'Coconut Grove Cafe', 'cafe', 'Kowdiar', 'Royal Road', 'coconut.grove@example.com', '+91-9876543222', 'dummy_password');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM businesses WHERE business_id = 'b113') THEN
        INSERT INTO businesses (business_id, business_name, category, location, address, email, phone, password)
        VALUES ('b113', 'Monsoon Cafe', 'cafe', 'Sreekaryam', 'Near College Junction', 'monsoon.cafe@example.com', '+91-9876543223', 'dummy_password');
    END IF;
END $$;

-- Insert offers for the businesses that exist
DO $$
BEGIN
    -- Malabar Kitchen offer
    IF NOT EXISTS (SELECT 1 FROM offers WHERE business_id = 'b100' AND title = 'Special Malabar Feast') THEN
        INSERT INTO offers (business_id, title, description, discount, validity, views, engagements)
        VALUES ('b100', 'Special Malabar Feast', 'Complete Kerala Sadhya experience', 20, CURRENT_DATE + INTERVAL '30 days', 150, 45);
    END IF;

    -- Kerala Cafe offer
    IF NOT EXISTS (SELECT 1 FROM offers WHERE business_id = 'b101' AND title = 'Morning Coffee Combo') THEN
        INSERT INTO offers (business_id, title, description, discount, validity, views, engagements)
        VALUES ('b101', 'Morning Coffee Combo', 'Kerala filter coffee with vada', 15, CURRENT_DATE + INTERVAL '15 days', 200, 80);
    END IF;

    -- Thalassery Biriyani House offer
    IF NOT EXISTS (SELECT 1 FROM offers WHERE business_id = 'b102' AND title = 'Family Biriyani Pack') THEN
        INSERT INTO offers (business_id, title, description, discount, validity, views, engagements)
        VALUES ('b102', 'Family Biriyani Pack', 'Thalassery Biriyani for 4', 25, CURRENT_DATE + INTERVAL '7 days', 300, 120);
    END IF;

    -- Kasavu World offer
    IF NOT EXISTS (SELECT 1 FROM offers WHERE business_id = 'b104' AND title = 'Onam Special Collection') THEN
        INSERT INTO offers (business_id, title, description, discount, validity, views, engagements)
        VALUES ('b104', 'Onam Special Collection', 'Traditional Kasavu Sarees', 30, CURRENT_DATE + INTERVAL '45 days', 180, 60);
    END IF;

    -- Kerala Massage Center offer
    IF NOT EXISTS (SELECT 1 FROM offers WHERE business_id = 'b107' AND title = 'Wellness Package') THEN
        INSERT INTO offers (business_id, title, description, discount, validity, views, engagements)
        VALUES ('b107', 'Wellness Package', 'Complete Ayurvedic treatment', 40, CURRENT_DATE + INTERVAL '60 days', 90, 30);
    END IF;
END $$;

-- Insert user activity data only for existing users and businesses
DO $$
BEGIN
    -- User activity for u1
    IF EXISTS (SELECT 1 FROM users WHERE user_id = 'u1') THEN
        -- View Malabar Kitchen
        IF NOT EXISTS (SELECT 1 FROM user_activity WHERE user_id = 'u1' AND business_id = 'b100' AND activity_type = 'view') THEN
            INSERT INTO user_activity (user_id, business_id, activity_type, created_at)
            VALUES ('u1', 'b100', 'view', CURRENT_TIMESTAMP - INTERVAL '2 days');
        END IF;

        -- Favorite Thalassery Biriyani House
        IF NOT EXISTS (SELECT 1 FROM user_activity WHERE user_id = 'u1' AND business_id = 'b102' AND activity_type = 'favorite') THEN
            INSERT INTO user_activity (user_id, business_id, activity_type, created_at)
            VALUES ('u1', 'b102', 'favorite', CURRENT_TIMESTAMP - INTERVAL '1 day');
        END IF;

        -- View Kasavu World
        IF NOT EXISTS (SELECT 1 FROM user_activity WHERE user_id = 'u1' AND business_id = 'b104' AND activity_type = 'view') THEN
            INSERT INTO user_activity (user_id, business_id, activity_type, created_at)
            VALUES ('u1', 'b104', 'view', CURRENT_TIMESTAMP - INTERVAL '3 days');
        END IF;
    END IF;
END $$; 