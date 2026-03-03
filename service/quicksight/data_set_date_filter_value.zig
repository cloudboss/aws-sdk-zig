/// Represents a date value used in filter conditions.
pub const DataSetDateFilterValue = struct {
    /// A static date value used for filtering.
    static_value: ?i64 = null,

    pub const json_field_names = .{
        .static_value = "StaticValue",
    };
};
