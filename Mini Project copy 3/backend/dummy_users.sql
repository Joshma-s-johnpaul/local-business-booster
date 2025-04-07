-- Insert dummy users if they don't exist
INSERT INTO users (user_id, username, email, password, phone)
SELECT 'u2', 'Jane Smith', 'jane@example.com', 'dummy_password', '+91-9876543232'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE user_id = 'u2');

INSERT INTO users (user_id, username, email, password, phone)
SELECT 'u3', 'Alice Johnson', 'alice@example.com', 'dummy_password', '+91-9876543233'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE user_id = 'u3');

-- Insert user preferences for new users
INSERT INTO user_preferences (user_id, preference_id)
SELECT 'u2', id FROM preferences WHERE preference_name IN ('healthcare', 'spa')
AND EXISTS (SELECT 1 FROM users WHERE user_id = 'u2');

INSERT INTO user_preferences (user_id, preference_id)
SELECT 'u3', id FROM preferences WHERE preference_name IN ('restaurant', 'entertainment')
AND EXISTS (SELECT 1 FROM users WHERE user_id = 'u3'); 