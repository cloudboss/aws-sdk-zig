/// An object that describes the details of a number filter.
pub const NumberFilter = struct {
    /// The lowest number to be included in the filter.
    lower_inclusive: ?f64 = null,

    /// The highest number to be included in the filter.
    upper_inclusive: ?f64 = null,

    pub const json_field_names = .{
        .lower_inclusive = "lowerInclusive",
        .upper_inclusive = "upperInclusive",
    };
};
