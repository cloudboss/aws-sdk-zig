const IsolineCarOptions = @import("isoline_car_options.zig").IsolineCarOptions;
const IsolineScooterOptions = @import("isoline_scooter_options.zig").IsolineScooterOptions;
const IsolineTruckOptions = @import("isoline_truck_options.zig").IsolineTruckOptions;

/// Travel mode related options for the provided travel mode.
pub const IsolineTravelModeOptions = struct {
    /// Travel mode options when the provided travel mode is "Car"
    car: ?IsolineCarOptions = null,

    /// Travel mode options when the provided travel mode is `Scooter`
    ///
    /// When travel mode is set to `Scooter`, then the avoidance option
    /// `ControlledAccessHighways` defaults to `true`.
    scooter: ?IsolineScooterOptions = null,

    /// Travel mode options when the provided travel mode is "Truck"
    truck: ?IsolineTruckOptions = null,

    pub const json_field_names = .{
        .car = "Car",
        .scooter = "Scooter",
        .truck = "Truck",
    };
};
