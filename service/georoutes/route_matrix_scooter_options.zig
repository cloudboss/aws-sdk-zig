const RouteMatrixVehicleLicensePlate = @import("route_matrix_vehicle_license_plate.zig").RouteMatrixVehicleLicensePlate;

/// Travel mode options when the provided travel mode is `Scooter`
pub const RouteMatrixScooterOptions = struct {
    /// The vehicle License Plate.
    license_plate: ?RouteMatrixVehicleLicensePlate,

    /// Maximum speed.
    ///
    /// **Unit**: `KilometersPerHour`
    max_speed: ?f64,

    /// The number of occupants in the vehicle.
    ///
    /// Default Value: `1`
    occupancy: ?i32,

    pub const json_field_names = .{
        .license_plate = "LicensePlate",
        .max_speed = "MaxSpeed",
        .occupancy = "Occupancy",
    };
};
