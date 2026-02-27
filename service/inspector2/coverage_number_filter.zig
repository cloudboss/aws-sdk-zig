/// The coverage number to be used in the filter.
pub const CoverageNumberFilter = struct {
    /// The lower inclusive for the coverage number.
    lower_inclusive: ?i64,

    /// The upper inclusive for the coverage number.>
    upper_inclusive: ?i64,

    pub const json_field_names = .{
        .lower_inclusive = "lowerInclusive",
        .upper_inclusive = "upperInclusive",
    };
};
