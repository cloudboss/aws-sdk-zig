/// The value input pf the numeric range filter.
pub const NumericRangeFilterValue = struct {
    /// The parameter that is used in the numeric range.
    parameter: ?[]const u8 = null,

    /// The static value of the numeric range filter.
    static_value: ?f64 = null,

    pub const json_field_names = .{
        .parameter = "Parameter",
        .static_value = "StaticValue",
    };
};
