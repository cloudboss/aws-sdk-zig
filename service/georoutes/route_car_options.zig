const RouteEngineType = @import("route_engine_type.zig").RouteEngineType;
const RouteVehicleLicensePlate = @import("route_vehicle_license_plate.zig").RouteVehicleLicensePlate;

/// Travel mode options when the provided travel mode is `Car`.
pub const RouteCarOptions = struct {
    /// Engine type of the vehicle.
    engine_type: ?RouteEngineType = null,

    /// The vehicle License Plate.
    license_plate: ?RouteVehicleLicensePlate = null,

    /// Maximum speed specified.
    ///
    /// **Unit**: `KilometersPerHour`
    max_speed: ?f64 = null,

    /// The number of occupants in the vehicle.
    ///
    /// Default Value: `1`
    occupancy: ?i32 = null,

    pub const json_field_names = .{
        .engine_type = "EngineType",
        .license_plate = "LicensePlate",
        .max_speed = "MaxSpeed",
        .occupancy = "Occupancy",
    };
};
