const IsolineEngineType = @import("isoline_engine_type.zig").IsolineEngineType;
const IsolineVehicleLicensePlate = @import("isoline_vehicle_license_plate.zig").IsolineVehicleLicensePlate;

/// Vehicle characteristics and preferences that affect routing for passenger
/// cars. This includes vehicle type, occupancy, and speed restrictions that may
/// influence which roads can be used and expected travel times.
pub const IsolineCarOptions = struct {
    /// The type of engine powering the vehicle, which may affect route calculation
    /// due to road restrictions or vehicle characteristics.
    ///
    /// * `INTERNAL_COMBUSTION`—Standard gasoline or diesel engine.
    /// * `ELECTRIC`—Battery electric vehicle.
    /// * `PLUGIN_HYBRID`—Combination of electric and internal combustion engines
    ///   with plug-in charging capability.
    engine_type: ?IsolineEngineType = null,

    /// License plate information used in regions where road access or routing
    /// restrictions are based on license plate numbers.
    license_plate: ?IsolineVehicleLicensePlate = null,

    /// The maximum speed of the vehicle in kilometers per hour. When specified,
    /// routes will not include roads with higher speed limits. Valid values range
    /// from 3.6 km/h (1 m/s) to 252 km/h (70 m/s).
    ///
    /// **Unit**: `kilometers per hour`
    max_speed: ?f64 = null,

    /// The number of occupants in the vehicle. This can affect route calculations
    /// by enabling the use of high-occupancy vehicle (HOV) lanes where minimum
    /// occupancy requirements are met.
    ///
    /// Default value: `1`
    occupancy: ?i32 = null,

    pub const json_field_names = .{
        .engine_type = "EngineType",
        .license_plate = "LicensePlate",
        .max_speed = "MaxSpeed",
        .occupancy = "Occupancy",
    };
};
