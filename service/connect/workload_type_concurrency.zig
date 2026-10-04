const CrossChannelWorkloadBehavior = @import("cross_channel_workload_behavior.zig").CrossChannelWorkloadBehavior;

/// Defines the maximum number of contacts an agent can handle simultaneously
/// for a specific channel and workload
/// type combination.
pub const WorkloadTypeConcurrency = struct {
    /// The maximum number of contacts an agent can handle simultaneously for a
    /// specific channel and workload type
    /// combination.
    ///
    /// Valid Range for `VOICE`: Minimum value of 1. Maximum value of 1.
    ///
    /// Valid Range for `CHAT`: Minimum value of 1. Maximum value of 10.
    ///
    /// Valid Range for `TASK`: Minimum value of 1. Maximum value of 10.
    concurrency: i32,

    /// Defines the cross-channel and workload type routing behavior for each
    /// channel and workload type combination
    /// that is enabled for this Routing Profile.
    cross_channel_workload_behavior: ?CrossChannelWorkloadBehavior = null,

    /// The value of the workload type.
    workload_type: []const u8,

    pub const json_field_names = .{
        .concurrency = "Concurrency",
        .cross_channel_workload_behavior = "CrossChannelWorkloadBehavior",
        .workload_type = "WorkloadType",
    };
};
