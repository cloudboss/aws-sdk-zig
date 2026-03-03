const VehicleWeightUnit = @import("vehicle_weight_unit.zig").VehicleWeightUnit;

/// Contains details about the truck's weight specifications. Used to avoid
/// roads that can't support or allow the total weight for requests that specify
/// `TravelMode` as `Truck`.
pub const TruckWeight = struct {
    /// The total weight of the truck.
    ///
    /// * For example, `3500`.
    total: ?f64 = null,

    /// The unit of measurement to use for the truck weight.
    ///
    /// Default Value: `Kilograms`
    unit: ?VehicleWeightUnit = null,

    pub const json_field_names = .{
        .total = "Total",
        .unit = "Unit",
    };
};
