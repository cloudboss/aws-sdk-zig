/// Represents individual aggregated results when grouping security findings for
/// each `GroupByField`.
pub const GroupByValue = struct {
    /// The number of findings for a specific `FieldValue` and `GroupByField`.
    count: ?i32 = null,

    /// The value of the field by which findings are grouped.
    field_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .count = "Count",
        .field_value = "FieldValue",
    };
};
