const RouteMatrixVehicleLicensePlate = @import("route_matrix_vehicle_license_plate.zig").RouteMatrixVehicleLicensePlate;

/// Travel mode options when the provided travel mode is `Car`.
pub const RouteMatrixCarOptions = struct {
    /// The vehicle License Plate.
    license_plate: ?RouteMatrixVehicleLicensePlate = null,

    /// Maximum speed
    ///
    /// **Unit**: `KilometersPerHour`
    max_speed: ?f64 = null,

    /// The number of occupants in the vehicle.
    ///
    /// Default Value: `1`
    occupancy: ?i32 = null,

    pub const json_field_names = .{
        .license_plate = "LicensePlate",
        .max_speed = "MaxSpeed",
        .occupancy = "Occupancy",
    };
};
