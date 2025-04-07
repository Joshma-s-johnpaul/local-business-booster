-- Seed data for businesses table
INSERT INTO businesses (business_id, business_name, category, location, address, password, email, phone) VALUES
-- Boutiques & Fashion Stores
('b100', 'Kerala Handloom Hub', 'boutique', 'pattom', '24/120 Pattom Palace Road, Near KSRTC Bus Stand', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'handloom.hub@gmail.com', '9847123401'),
('b101', 'Kasavu Boutique', 'boutique', 'thampanoor', '45 MG Road, Opposite Railway Station', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'kasavu.boutique@gmail.com', '9847123402'),
('b102', 'Traditional Threads', 'boutique', 'kazhakootam', 'Technopark Campus Road, Near Technopark', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'threads.traditional@gmail.com', '9847123403'),

-- Electronics & Gadgets
('b103', 'Tech Paradise', 'electronics', 'pattom', '56 Pattom-Maruthankuzhi Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'tech.paradise@gmail.com', '9847123404'),
('b104', 'Digital Dreams', 'electronics', 'kazhakootam', 'Technopark Phase III Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'digital.dreams@gmail.com', '9847123405'),

-- Supermarkets & Grocery Stores
('b105', 'Kerala Fresh Mart', 'supermarket', 'sreekaryam', '23/178 Sreekaryam Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'fresh.mart@gmail.com', '9847123406'),
('b106', 'Nadan Grocery Hub', 'supermarket', 'nalanchira', '45/167 Nalanchira Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'nadan.grocery@gmail.com', '9847123407'),
('b107', 'Spice Corner Market', 'supermarket', 'kesavadasapuram', '78/145 Kesavadasapuram Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'spice.corner@gmail.com', '9847123408'),

-- Bookstores & Stationery
('b108', 'Kerala Book House', 'bookstore', 'thampanoor', '34 Central Road, Near KSRTC', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'kerala.books@gmail.com', '9847123409'),
('b109', 'Students Corner', 'bookstore', 'pattom', '89/234 Pattom Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'students.corner@gmail.com', '9847123410'),

-- Cafés & Bakeries
('b110', 'Malabar Coffee House', 'cafe', 'pattom', '67/89 Pattom Palace Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'malabar.coffee@gmail.com', '9847123411'),
('b111', 'Kerala Bakes', 'cafe', 'kesavadasapuram', '90/123 Kesavadasapuram Main Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'kerala.bakes@gmail.com', '9847123412'),
('b112', 'Parotta Paradise', 'cafe', 'kazhakootam', '45/678 Kazhakootam Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'parotta.paradise@gmail.com', '9847123413'),

-- Restaurants & Fine Dining
('b113', 'Malabar Kitchen', 'restaurant', 'pattom', '78/90 Pattom-Maruthankuzhi Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'malabar.kitchen@gmail.com', '9847123414'),
('b114', 'Kerala Feast', 'restaurant', 'thampanoor', '56/789 MG Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'kerala.feast@gmail.com', '9847123415'),
('b115', 'Seafood Harbor', 'restaurant', 'kazhakootam', '34/567 Technopark Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'seafood.harbor@gmail.com', '9847123416'),

-- Street Food & Quick Bites
('b116', 'Thattukada Junction', 'street_food', 'sreekaryam', '23/456 Sreekaryam Main Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'thattukada.junction@gmail.com', '9847123417'),
('b117', 'Kerala Street Bites', 'street_food', 'pattom', '89/123 Pattom Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'street.bites@gmail.com', '9847123418'),
('b118', 'Chai Point Express', 'street_food', 'thampanoor', '45/678 Railway Station Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'chai.point@gmail.com', '9847123419'),

-- Organic & Health Food
('b119', 'Nature Fresh Kerala', 'organic', 'nalanchira', '67/890 Nalanchira Main Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'nature.fresh@gmail.com', '9847123420'),
('b120', 'Organic Valley', 'organic', 'sreekaryam', '34/567 Sreekaryam Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'organic.valley@gmail.com', '9847123421'),
('b121', 'Green Earth Foods', 'organic', 'kazhakootam', '78/901 Technopark Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'green.earth@gmail.com', '9847123422'),

-- Salons & Spas
('b122', 'Kerala Ayur Beauty', 'salon', 'pattom', '90/123 Pattom Palace Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'ayur.beauty@gmail.com', '9847123423'),
('b123', 'Herbal Touch Spa', 'salon', 'kesavadasapuram', '56/789 Kesavadasapuram Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'herbal.touch@gmail.com', '9847123424'),
('b124', 'Style Hub Kerala', 'salon', 'thampanoor', '23/456 MG Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'style.hub@gmail.com', '9847123425'),

-- Wellness & Ayurveda Centers
('b125', 'Ayurveda Heritage', 'wellness', 'nalanchira', '45/678 Nalanchira Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'ayurveda.heritage@gmail.com', '9847123426'),
('b126', 'Kerala Healing Center', 'wellness', 'pattom', '78/901 Pattom Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'healing.center@gmail.com', '9847123427'),
('b127', 'Mind & Body Wellness', 'wellness', 'sreekaryam', '90/123 Sreekaryam Main Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'mind.body@gmail.com', '9847123428'),

-- Medical Stores & Pharmacies
('b128', 'Kerala Medical Hub', 'pharmacy', 'thampanoor', '56/789 Central Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'medical.hub@gmail.com', '9847123429'),
('b129', 'Ayur Pharma Plus', 'pharmacy', 'kazhakootam', '23/456 Technopark Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'ayur.pharma@gmail.com', '9847123430'),
('b130', 'Health First Medicals', 'pharmacy', 'pattom', '67/890 Pattom Palace Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'health.first@gmail.com', '9847123431'),

-- Art Galleries & Cultural Centers
('b131', 'Kerala Arts Collective', 'art_gallery', 'sreekaryam', '34/567 Sreekaryam Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'arts.collective@gmail.com', '9847123432'),
('b132', 'Heritage Art House', 'art_gallery', 'thampanoor', '78/901 MG Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'heritage.art@gmail.com', '9847123433'),
('b133', 'Cultural Canvas', 'art_gallery', 'pattom', '90/123 Pattom Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'cultural.canvas@gmail.com', '9847123434'),

-- Entertainment & Gaming
('b134', 'Game Zone Kerala', 'entertainment', 'kazhakootam', '56/789 Technopark Campus', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'game.zone@gmail.com', '9847123435'),
('b135', 'Family Fun World', 'entertainment', 'sreekaryam', '23/456 Sreekaryam Main Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'fun.world@gmail.com', '9847123436'),
('b136', 'Kerala Gaming Hub', 'entertainment', 'kesavadasapuram', '67/890 Kesavadasapuram Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'gaming.hub@gmail.com', '9847123437'),

-- Traditional Crafts & Handicrafts
('b137', 'Kerala Handicrafts', 'handicrafts', 'pattom', '34/567 Pattom Palace Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'kerala.handicrafts@gmail.com', '9847123438'),
('b138', 'Artisan Gallery', 'handicrafts', 'thampanoor', '78/901 Central Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'artisan.gallery@gmail.com', '9847123439'),
('b139', 'Traditional Treasures', 'handicrafts', 'nalanchira', '90/123 Nalanchira Main Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'traditional.treasures@gmail.com', '9847123440'),

-- Jewelry & Accessories
('b140', 'Kerala Gold House', 'jewelry', 'thampanoor', '56/789 MG Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'gold.house@gmail.com', '9847123441'),
('b141', 'Traditional Jewels', 'jewelry', 'pattom', '23/456 Pattom Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'traditional.jewels@gmail.com', '9847123442'),
('b142', 'Gem Paradise', 'jewelry', 'kazhakootam', '67/890 Technopark Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'gem.paradise@gmail.com', '9847123443'),

-- Home Decor & Furnishing
('b143', 'Kerala Home Studio', 'home_decor', 'sreekaryam', '34/567 Sreekaryam Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'home.studio@gmail.com', '9847123444'),
('b144', 'Traditional Interiors', 'home_decor', 'kesavadasapuram', '78/901 Kesavadasapuram Main Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'traditional.interiors@gmail.com', '9847123445'),
('b145', 'Ethnic Home Arts', 'home_decor', 'nalanchira', '90/123 Nalanchira Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'ethnic.arts@gmail.com', '9847123446'),

-- Sports & Fitness
('b146', 'Kerala Sports Hub', 'sports', 'kazhakootam', '56/789 Technopark Campus', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'sports.hub@gmail.com', '9847123447'),
('b147', 'Fitness First Kerala', 'sports', 'pattom', '23/456 Pattom Palace Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'fitness.first@gmail.com', '9847123448'),
('b148', 'Active Life Gym', 'sports', 'sreekaryam', '67/890 Sreekaryam Main Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'active.life@gmail.com', '9847123449'),

-- Music & Musical Instruments
('b149', 'Kerala Music House', 'music', 'thampanoor', '34/567 Central Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'music.house@gmail.com', '9847123450'),

-- Traditional Musical Instruments
('b150', 'Classical Instruments', 'music', 'kesavadasapuram', '78/901 Kesavadasapuram Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'classical.instruments@gmail.com', '9847123451'),
('b151', 'Rhythm House', 'music', 'nalanchira', '90/123 Nalanchira Main Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'rhythm.house@gmail.com', '9847123452'),

-- Educational Services
('b152', 'Kerala Learning Center', 'education', 'kazhakootam', '56/789 Technopark Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'learning.center@gmail.com', '9847123453'),
('b153', 'Knowledge Hub', 'education', 'pattom', '23/456 Pattom Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'knowledge.hub@gmail.com', '9847123454'),
('b154', 'Skill Development Institute', 'education', 'sreekaryam', '67/890 Sreekaryam Main Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'skill.dev@gmail.com', '9847123455'),

-- Photography Studios
('b155', 'Kerala Moments', 'photography', 'thampanoor', '34/567 MG Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'kerala.moments@gmail.com', '9847123456'),
('b156', 'Creative Captures', 'photography', 'kesavadasapuram', '78/901 Kesavadasapuram Main Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'creative.captures@gmail.com', '9847123457'),
('b157', 'Digital Studio Pro', 'photography', 'nalanchira', '90/123 Nalanchira Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'digital.studio@gmail.com', '9847123458'),

-- Travel & Tourism
('b158', 'Kerala Tours & Travels', 'travel', 'kazhakootam', '56/789 Technopark Campus', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'kerala.tours@gmail.com', '9847123459'),
('b159', 'Backwater Adventures', 'travel', 'pattom', '23/456 Pattom Palace Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'backwater.adventures@gmail.com', '9847123460'),
('b160', 'Heritage Tours Kerala', 'travel', 'sreekaryam', '67/890 Sreekaryam Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'heritage.tours@gmail.com', '9847123461'),

-- Auto Services
('b161', 'Kerala Auto Care', 'auto', 'thampanoor', '34/567 Central Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'auto.care@gmail.com', '9847123462'),
('b162', 'Quick Service Center', 'auto', 'kesavadasapuram', '78/901 Kesavadasapuram Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'quick.service@gmail.com', '9847123463'),
('b163', 'Vehicle Hub Kerala', 'auto', 'nalanchira', '90/123 Nalanchira Main Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'vehicle.hub@gmail.com', '9847123464'),

-- Pet Care Services
('b164', 'Kerala Pet Care', 'pet_care', 'kazhakootam', '56/789 Technopark Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'pet.care@gmail.com', '9847123465'),
('b165', 'Animal Friends Clinic', 'pet_care', 'pattom', '23/456 Pattom Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'animal.friends@gmail.com', '9847123466'),
('b166', 'Pet Paradise Kerala', 'pet_care', 'sreekaryam', '67/890 Sreekaryam Main Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'pet.paradise@gmail.com', '9847123467'),

-- Printing & Design
('b167', 'Kerala Print House', 'printing', 'thampanoor', '34/567 MG Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'print.house@gmail.com', '9847123468'),
('b168', 'Creative Design Studio', 'printing', 'kesavadasapuram', '78/901 Kesavadasapuram Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'design.studio@gmail.com', '9847123469'),
('b169', 'Digital Print Solutions', 'printing', 'nalanchira', '90/123 Nalanchira Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'print.solutions@gmail.com', '9847123470'),

-- Mobile & Computer Repair
('b170', 'Tech Care Kerala', 'tech_repair', 'kazhakootam', '56/789 Technopark Campus', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'tech.care@gmail.com', '9847123471'),
('b171', 'Mobile Solutions', 'tech_repair', 'pattom', '23/456 Pattom Palace Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'mobile.solutions@gmail.com', '9847123472'),
('b172', 'Computer Care Center', 'tech_repair', 'sreekaryam', '67/890 Sreekaryam Junction', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'computer.care@gmail.com', '9847123473'),

-- Language & Cultural Centers
('b173', 'Kerala Cultural Center', 'cultural', 'thampanoor', '34/567 Central Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'cultural.center@gmail.com', '9847123474'),
('b174', 'Malayalam Learning Hub', 'cultural', 'kesavadasapuram', '78/901 Kesavadasapuram Main Road', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN.B9ElPF5x5qPFdDrPVi', 'malayalam.hub@gmail.com', '9847123475'); 