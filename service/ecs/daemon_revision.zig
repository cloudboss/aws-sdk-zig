const DaemonContainerImage = @import("daemon_container_image.zig").DaemonContainerImage;
const DaemonPropagateTags = @import("daemon_propagate_tags.zig").DaemonPropagateTags;

/// Information about a daemon revision. A daemon revision is a snapshot of the
/// daemon's configuration at the time a deployment was initiated.
pub const DaemonRevision = struct {
    /// The Amazon Resource Name (ARN) of the cluster that hosts the daemon.
    cluster_arn: ?[]const u8 = null,

    /// The container images used by the daemon revision.
    container_images: ?[]const DaemonContainerImage = null,

    /// The Unix timestamp for the time when the daemon revision was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the daemon for this revision.
    daemon_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the daemon revision.
    daemon_revision_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the daemon task definition used by this
    /// revision.
    daemon_task_definition_arn: ?[]const u8 = null,

    /// Specifies whether Amazon ECS managed tags are turned on for the daemon
    /// tasks.
    enable_ecs_managed_tags: ?bool = null,

    /// Specifies whether the execute command functionality is turned on for the
    /// daemon tasks.
    enable_execute_command: ?bool = null,

    /// Specifies whether tags are propagated from the daemon to the daemon tasks.
    propagate_tags: ?DaemonPropagateTags = null,

    pub const json_field_names = .{
        .cluster_arn = "clusterArn",
        .container_images = "containerImages",
        .created_at = "createdAt",
        .daemon_arn = "daemonArn",
        .daemon_revision_arn = "daemonRevisionArn",
        .daemon_task_definition_arn = "daemonTaskDefinitionArn",
        .enable_ecs_managed_tags = "enableECSManagedTags",
        .enable_execute_command = "enableExecuteCommand",
        .propagate_tags = "propagateTags",
    };
};
