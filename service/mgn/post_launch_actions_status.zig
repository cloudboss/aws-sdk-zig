const JobPostLaunchActionsLaunchStatus = @import("job_post_launch_actions_launch_status.zig").JobPostLaunchActionsLaunchStatus;

/// Status of the Post Launch Actions running on the Test or Cutover instance.
pub const PostLaunchActionsStatus = struct {
    /// List of Post Launch Action status.
    post_launch_actions_launch_status_list: ?[]const JobPostLaunchActionsLaunchStatus,

    /// Time where the AWS Systems Manager was detected as running on the Test or
    /// Cutover instance.
    ssm_agent_discovery_datetime: ?[]const u8,

    pub const json_field_names = .{
        .post_launch_actions_launch_status_list = "postLaunchActionsLaunchStatusList",
        .ssm_agent_discovery_datetime = "ssmAgentDiscoveryDatetime",
    };
};
