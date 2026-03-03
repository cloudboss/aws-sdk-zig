/// Represents a list of string values used in filter conditions.
pub const DataSetStringListFilterValue = struct {
    /// A list of static string values used for filtering.
    static_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .static_values = "StaticValues",
    };
};
