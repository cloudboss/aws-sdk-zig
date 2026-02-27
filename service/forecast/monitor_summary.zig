/// Provides a summary of the monitor properties used in the ListMonitors
/// operation. To get a complete set of properties,
/// call the DescribeMonitor operation, and provide the listed
/// `MonitorArn`.
pub const MonitorSummary = struct {
    /// When the monitor resource was created.
    creation_time: ?i64,

    /// The last time the monitor resource was modified. The timestamp depends on
    /// the status of the
    /// job:
    ///
    /// * `CREATE_PENDING` - The `CreationTime`.
    ///
    /// * `CREATE_IN_PROGRESS` - The current timestamp.
    ///
    /// * `STOPPED` - When the resource stopped.
    ///
    /// * `ACTIVE` or `CREATE_FAILED` - When the monitor creation finished or
    /// failed.
    last_modification_time: ?i64,

    /// The Amazon Resource Name (ARN) of the monitor resource.
    monitor_arn: ?[]const u8,

    /// The name of the monitor resource.
    monitor_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the predictor being monitored.
    resource_arn: ?[]const u8,

    /// The status of the monitor. States include:
    ///
    /// * `ACTIVE`
    ///
    /// * `ACTIVE_STOPPING`, `ACTIVE_STOPPED`
    ///
    /// * `UPDATE_IN_PROGRESS`
    ///
    /// * `CREATE_PENDING`, `CREATE_IN_PROGRESS`, `CREATE_FAILED`
    ///
    /// * `DELETE_PENDING`, `DELETE_IN_PROGRESS`, `DELETE_FAILED`
    status: ?[]const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_modification_time = "LastModificationTime",
        .monitor_arn = "MonitorArn",
        .monitor_name = "MonitorName",
        .resource_arn = "ResourceArn",
        .status = "Status",
    };
};
