/// Information about a capacity provider associated with a daemon revision.
pub const DaemonCapacityProvider = struct {
    /// The Amazon Resource Name (ARN) of the capacity provider.
    arn: ?[]const u8 = null,

    /// The number of daemon tasks running on this capacity provider.
    running_count: i32 = 0,

    /// The number of instances on this capacity provider that are running without
    /// the daemon task. This applies to daemons that aren't critical, where the
    /// instance remains available for your other tasks even if the daemon task
    /// can't start or stops. These instances aren't included in `runningCount`.
    without_daemon_count: i32 = 0,

    pub const json_field_names = .{
        .arn = "arn",
        .running_count = "runningCount",
        .without_daemon_count = "withoutDaemonCount",
    };
};
