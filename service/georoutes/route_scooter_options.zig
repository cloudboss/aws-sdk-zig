const RouteEngineType = @import("route_engine_type.zig").RouteEngineType;
const RouteVehicleLicensePlate = @import("route_vehicle_license_plate.zig").RouteVehicleLicensePlate;

/// Travel mode options when the provided travel mode is `Scooter`
pub const RouteScooterOptions = struct {
    /// Engine type of the vehicle.
    engine_type: ?RouteEngineType,

    /// The vehicle License Plate.
    license_plate: ?RouteVehicleLicensePlate,

    /// Maximum speed
    ///
    /// **Unit**: `KilometersPerHour`
    max_speed: ?f64,

    /// The number of occupants in the vehicle.
    ///
    /// Default Value: `1`
    occupancy: ?i32,

    pub const json_field_names = .{
        .engine_type = "EngineType",
        .license_plate = "LicensePlate",
        .max_speed = "MaxSpeed",
        .occupancy = "Occupancy",
    };
};
