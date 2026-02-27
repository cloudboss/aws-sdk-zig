/// A rule defined to grant access on one or more restricted columns.
/// Each dataset can have multiple rules.
/// To create a restricted column, you add it to one or more rules.
/// Each rule must contain at least one column and at least one user or group.
/// To be able to see a restricted column, a user or group needs to be added
/// to a rule for that column.
pub const ColumnLevelPermissionRule = struct {
    /// An array of column names.
    column_names: ?[]const []const u8,

    /// An array of Amazon Resource Names (ARNs) for Quick Sight users or groups.
    principals: ?[]const []const u8,

    pub const json_field_names = .{
        .column_names = "ColumnNames",
        .principals = "Principals",
    };
};
