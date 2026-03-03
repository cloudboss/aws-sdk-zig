const IsolineEngineType = @import("isoline_engine_type.zig").IsolineEngineType;
const IsolineVehicleLicensePlate = @import("isoline_vehicle_license_plate.zig").IsolineVehicleLicensePlate;

/// Travel mode options when the provided travel mode is `Car`.
pub const IsolineCarOptions = struct {
    /// Engine type of the vehicle.
    engine_type: ?IsolineEngineType = null,

    /// The vehicle License Plate.
    license_plate: ?IsolineVehicleLicensePlate = null,

    /// Maximum speed.
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
