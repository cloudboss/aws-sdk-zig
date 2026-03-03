const LaunchActionsStatus = @import("launch_actions_status.zig").LaunchActionsStatus;
const LaunchStatus = @import("launch_status.zig").LaunchStatus;

/// Represents a server participating in an asynchronous Job.
pub const ParticipatingServer = struct {
    /// The post-launch action runs of a participating server.
    launch_actions_status: ?LaunchActionsStatus = null,

    /// The launch status of a participating server.
    launch_status: ?LaunchStatus = null,

    /// The Recovery Instance ID of a participating server.
    recovery_instance_id: ?[]const u8 = null,

    /// The Source Server ID of a participating server.
    source_server_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .launch_actions_status = "launchActionsStatus",
        .launch_status = "launchStatus",
        .recovery_instance_id = "recoveryInstanceID",
        .source_server_id = "sourceServerID",
    };
};
