const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;

/// Filters for listing network migration executions.
pub const ListNetworkMigrationExecutionRequestFilters = struct {
    /// A list of execution IDs to filter by.
    network_migration_execution_i_ds: ?[]const []const u8 = null,

    /// A list of execution statuses to filter by.
    network_migration_execution_statuses: ?[]const ExecutionStatus = null,

    pub const json_field_names = .{
        .network_migration_execution_i_ds = "networkMigrationExecutionIDs",
        .network_migration_execution_statuses = "networkMigrationExecutionStatuses",
    };
};
