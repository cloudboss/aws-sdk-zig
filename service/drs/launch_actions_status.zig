const LaunchActionRun = @import("launch_action_run.zig").LaunchActionRun;

/// Launch actions status.
pub const LaunchActionsStatus = struct {
    /// List of post launch action status.
    runs: ?[]const LaunchActionRun = null,

    /// Time where the AWS Systems Manager was detected as running on the launched
    /// instance.
    ssm_agent_discovery_datetime: ?[]const u8 = null,

    pub const json_field_names = .{
        .runs = "runs",
        .ssm_agent_discovery_datetime = "ssmAgentDiscoveryDatetime",
    };
};
