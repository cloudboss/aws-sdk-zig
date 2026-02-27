/// An object that describes the details of a number filter.
pub const NumberFilter = struct {
    /// The lowest number to be included in the filter.
    lower_inclusive: ?f64,

    /// The highest number to be included in the filter.
    upper_inclusive: ?f64,

    pub const json_field_names = .{
        .lower_inclusive = "lowerInclusive",
        .upper_inclusive = "upperInclusive",
    };
};
