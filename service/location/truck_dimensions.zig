const DimensionUnit = @import("dimension_unit.zig").DimensionUnit;

/// Contains details about the truck dimensions in the unit of measurement that
/// you specify. Used to filter out roads that can't support or allow the
/// specified dimensions for requests that specify `TravelMode` as `Truck`.
pub const TruckDimensions = struct {
    /// The height of the truck.
    ///
    /// * For example, `4.5`.
    ///
    /// For routes calculated with a HERE resource, this value must be between 0 and
    /// 50 meters.
    height: ?f64 = null,

    /// The length of the truck.
    ///
    /// * For example, `15.5`.
    ///
    /// For routes calculated with a HERE resource, this value must be between 0 and
    /// 300 meters.
    length: ?f64 = null,

    /// Specifies the unit of measurement for the truck dimensions.
    ///
    /// Default Value: `Meters`
    unit: ?DimensionUnit = null,

    /// The width of the truck.
    ///
    /// * For example, `4.5`.
    ///
    /// For routes calculated with a HERE resource, this value must be between 0 and
    /// 50 meters.
    width: ?f64 = null,

    pub const json_field_names = .{
        .height = "Height",
        .length = "Length",
        .unit = "Unit",
        .width = "Width",
    };
};
