const DaemonCapacityProvider = @import("daemon_capacity_provider.zig").DaemonCapacityProvider;

/// Details about a daemon revision, including the running task counts per
/// capacity provider.
pub const DaemonRevisionDetail = struct {
    /// The Amazon Resource Name (ARN) of the daemon revision.
    arn: ?[]const u8 = null,

    /// The capacity providers associated with this daemon revision.
    capacity_providers: ?[]const DaemonCapacityProvider = null,

    /// The total number of daemon tasks running for this revision.
    total_running_count: i32 = 0,

    pub const json_field_names = .{
        .arn = "arn",
        .capacity_providers = "capacityProviders",
        .total_running_count = "totalRunningCount",
    };
};
