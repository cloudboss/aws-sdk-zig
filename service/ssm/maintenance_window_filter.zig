/// Filter used in the request. Supported filter keys depend on the API
/// operation that includes
/// the filter. API operations that use `MaintenanceWindowFilter>` include the
/// following:
///
/// * DescribeMaintenanceWindowExecutions
///
/// * DescribeMaintenanceWindowExecutionTaskInvocations
///
/// * DescribeMaintenanceWindowExecutionTasks
///
/// * DescribeMaintenanceWindows
///
/// * DescribeMaintenanceWindowTargets
///
/// * DescribeMaintenanceWindowTasks
pub const MaintenanceWindowFilter = struct {
    /// The name of the filter.
    key: ?[]const u8 = null,

    /// The filter values.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};
