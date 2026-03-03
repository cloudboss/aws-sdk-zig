const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;

/// Defines different defaults to the users or groups based on mapping.
pub const DynamicDefaultValue = struct {
    /// The column that contains the default value of each user or group.
    default_value_column: ColumnIdentifier,

    /// The column that contains the group name.
    group_name_column: ?ColumnIdentifier = null,

    /// The column that contains the username.
    user_name_column: ?ColumnIdentifier = null,

    pub const json_field_names = .{
        .default_value_column = "DefaultValueColumn",
        .group_name_column = "GroupNameColumn",
        .user_name_column = "UserNameColumn",
    };
};
