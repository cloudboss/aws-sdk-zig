/// Provides information about the monitor resource.
pub const MonitorInfo = struct {
    /// The Amazon Resource Name (ARN) of the monitor resource.
    monitor_arn: ?[]const u8 = null,

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
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .monitor_arn = "MonitorArn",
        .status = "Status",
    };
};
