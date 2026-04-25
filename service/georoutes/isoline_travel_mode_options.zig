const IsolineCarOptions = @import("isoline_car_options.zig").IsolineCarOptions;
const IsolineScooterOptions = @import("isoline_scooter_options.zig").IsolineScooterOptions;
const IsolineTruckOptions = @import("isoline_truck_options.zig").IsolineTruckOptions;

/// Mode-specific routing options that further refine how reachable areas are
/// calculated. Options are only considered when they match the selected travel
/// mode.
pub const IsolineTravelModeOptions = struct {
    /// Options specific to passenger vehicle routing (`Car`, such as vehicle
    /// characteristics and license plate restrictions.
    car: ?IsolineCarOptions = null,

    /// Options specific to scooter routing (`Scooter`, such as vehicle
    /// characteristics and license plate restrictions.
    ///
    /// When using the `Scooter` travel mode, controlled-access highways are
    /// automatically avoided unless explicitly allowed.
    scooter: ?IsolineScooterOptions = null,

    /// Options specific to commercial truck routing (`Truck`, including vehicle
    /// dimensions, weight limits, and hazardous cargo specifications.
    truck: ?IsolineTruckOptions = null,

    pub const json_field_names = .{
        .car = "Car",
        .scooter = "Scooter",
        .truck = "Truck",
    };
};
