/// Represents a numeric value used in filter conditions.
pub const DataSetNumericFilterValue = struct {
    /// A static numeric value used for filtering.
    static_value: ?f64 = null,

    pub const json_field_names = .{
        .static_value = "StaticValue",
    };
};
