const Location = require('../models/Location'); // Your Location model (replace it if you have a different one)

// Get all locations or a filtered list of locations (for example, based on a query parameter like city)
exports.getLocation = async (req, res) => {
    try {
        // You can add filters based on query params, like city, type of location, etc.
        const locations = await Location.find(); // If you want all locations
        res.json(locations);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching locations', error });
    }
};

// Add a new location (for example, adding a new pet shop or vet clinic)
exports.addLocation = async (req, res) => {
    const { name, address, city, contact } = req.body;

    try {
        // Creating a new location document
        const newLocation = new Location({
            name,
            address,
            city,
            contact
        });

        // Save the new location to the database
        await newLocation.save();

        res.status(201).json({ message: 'Location added successfully', newLocation });
    } catch (error) {
        res.status(500).json({ message: 'Error adding location', error });
    }
};
