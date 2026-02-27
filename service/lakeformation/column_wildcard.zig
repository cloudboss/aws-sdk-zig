/// A wildcard object, consisting of an optional list of excluded column names
/// or indexes.
pub const ColumnWildcard = struct {
    /// Excludes column names. Any column with this name will be excluded.
    excluded_column_names: ?[]const []const u8,

    pub const json_field_names = .{
        .excluded_column_names = "ExcludedColumnNames",
    };
};
