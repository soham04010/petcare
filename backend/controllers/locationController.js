const Location = require('../models/Location'); // Your Location model

// Get all locations or filtered locations (for example, based on a query parameter like city)
exports.getLocation = async (req, res) => {
    try {
        const locations = await Location.find(); // Fetch all locations
        res.json(locations);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching locations', error });
    }
};

// Add a new location (for example, adding a new pet shop or vet clinic)
exports.addLocation = async (req, res) => {
    const { name, address, city, contact, latitude, longitude } = req.body;

    try {
        // Creating a new location document with geospatial coordinates
        const newLocation = new Location({
            name,
            address,
            city,
            contact,
            location: { type: "Point", coordinates: [longitude, latitude] }
        });

        // Save the new location to the database
        await newLocation.save();

        res.status(201).json({ message: 'Location added successfully', newLocation });
    } catch (error) {
        res.status(500).json({ message: 'Error adding location', error });
    }
};

// Get nearby locations within a 5km radius using MongoDB geospatial query
exports.findNearbyLocations = async (req, res) => {
    try {
        const lat = parseFloat(req.query.lat);
        const lon = parseFloat(req.query.lon);

        // Use MongoDB Geospatial Index for optimized search
        const locations = await Location.find({
            location: {
                $near: {
                    $geometry: { type: "Point", coordinates: [lon, lat] },
                    $maxDistance: 5000 // 5km radius
                }
            }
        }).limit(10); // Limit results to prevent overload

        res.json(locations);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching nearby locations', error });
    }
};
