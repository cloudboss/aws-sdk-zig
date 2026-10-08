/// A price increase percentage range with minimum, maximum, and default values.
pub const PercentageRange = struct {
    /// The percentage increase applied by default when no other value is finalized
    /// before the adjustment deadline. Falls between `minimumValue` and
    /// `maximumValue`.
    default_value: []const u8,

    /// The maximum percentage by which the price can increase at each renewal
    /// cycle.
    maximum_value: []const u8,

    /// The minimum percentage by which the price can increase at each renewal
    /// cycle.
    minimum_value: []const u8,

    pub const json_field_names = .{
        .default_value = "defaultValue",
        .maximum_value = "maximumValue",
        .minimum_value = "minimumValue",
    };
};
