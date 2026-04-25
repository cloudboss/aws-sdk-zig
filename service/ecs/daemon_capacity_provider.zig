/// Information about a capacity provider associated with a daemon revision.
pub const DaemonCapacityProvider = struct {
    /// The Amazon Resource Name (ARN) of the capacity provider.
    arn: ?[]const u8 = null,

    /// The number of daemon tasks running on this capacity provider.
    running_count: i32 = 0,

    pub const json_field_names = .{
        .arn = "arn",
        .running_count = "runningCount",
    };
};
