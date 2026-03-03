/// Represents a string value used in filter conditions.
pub const DataSetStringFilterValue = struct {
    /// A static string value used for filtering.
    static_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .static_value = "StaticValue",
    };
};
