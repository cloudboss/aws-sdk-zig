const RowLevelPermissionDataSet = @import("row_level_permission_data_set.zig").RowLevelPermissionDataSet;
const RowLevelPermissionTagConfiguration = @import("row_level_permission_tag_configuration.zig").RowLevelPermissionTagConfiguration;

/// Configuration for row level security.
pub const RowLevelPermissionConfiguration = struct {
    row_level_permission_data_set: ?RowLevelPermissionDataSet = null,

    tag_configuration: ?RowLevelPermissionTagConfiguration = null,

    pub const json_field_names = .{
        .row_level_permission_data_set = "RowLevelPermissionDataSet",
        .tag_configuration = "TagConfiguration",
    };
};
