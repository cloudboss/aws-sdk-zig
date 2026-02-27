const DataTableAccessControlConfiguration = @import("data_table_access_control_configuration.zig").DataTableAccessControlConfiguration;

/// Contains granular access control configuration for security profiles,
/// including data table access
/// permissions.
pub const GranularAccessControlConfiguration = struct {
    /// The access control configuration for data tables.
    data_table_access_control_configuration: ?DataTableAccessControlConfiguration,

    pub const json_field_names = .{
        .data_table_access_control_configuration = "DataTableAccessControlConfiguration",
    };
};
