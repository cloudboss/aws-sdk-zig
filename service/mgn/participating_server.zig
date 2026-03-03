const LaunchStatus = @import("launch_status.zig").LaunchStatus;
const PostLaunchActionsStatus = @import("post_launch_actions_status.zig").PostLaunchActionsStatus;

/// Server participating in Job.
pub const ParticipatingServer = struct {
    /// Participating server's launched ec2 instance ID.
    launched_ec_2_instance_id: ?[]const u8 = null,

    /// Participating server launch status.
    launch_status: ?LaunchStatus = null,

    /// Participating server's Post Launch Actions Status.
    post_launch_actions_status: ?PostLaunchActionsStatus = null,

    /// Participating server Source Server ID.
    source_server_id: []const u8,

    pub const json_field_names = .{
        .launched_ec_2_instance_id = "launchedEc2InstanceID",
        .launch_status = "launchStatus",
        .post_launch_actions_status = "postLaunchActionsStatus",
        .source_server_id = "sourceServerID",
    };
};
