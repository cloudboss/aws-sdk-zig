const LifecycleExecutionResourceAction = @import("lifecycle_execution_resource_action.zig").LifecycleExecutionResourceAction;
const LifecycleExecutionSnapshotResource = @import("lifecycle_execution_snapshot_resource.zig").LifecycleExecutionSnapshotResource;
const LifecycleExecutionResourceState = @import("lifecycle_execution_resource_state.zig").LifecycleExecutionResourceState;

/// Contains details for a resource that the runtime instance of the
/// lifecycle policy identified for action.
pub const LifecycleExecutionResource = struct {
    /// The account that owns the impacted resource.
    account_id: ?[]const u8 = null,

    /// The action to take for the identified resource.
    action: ?LifecycleExecutionResourceAction = null,

    /// The ending timestamp from the lifecycle action that was applied to the
    /// resource.
    end_time: ?i64 = null,

    /// For an impacted container image, this identifies a list of URIs for
    /// associated
    /// container images distributed to ECR repositories.
    image_uris: ?[]const []const u8 = null,

    /// The Amazon Web Services Region where the lifecycle execution resource is
    /// stored.
    region: ?[]const u8 = null,

    /// Identifies the impacted resource. The resource ID depends on the type of
    /// resource, as follows.
    ///
    /// * Image Builder image resources: Amazon Resource Name (ARN)
    ///
    /// * Distributed AMIs: AMI ID
    ///
    /// * Container images distributed to an ECR repository: image URI or SHA Digest
    resource_id: ?[]const u8 = null,

    /// A list of associated resource snapshots for the impacted resource if
    /// it’s an AMI.
    snapshots: ?[]const LifecycleExecutionSnapshotResource = null,

    /// The starting timestamp from the lifecycle action that was applied to the
    /// resource.
    start_time: ?i64 = null,

    /// The runtime state for the lifecycle execution.
    state: ?LifecycleExecutionResourceState = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .action = "action",
        .end_time = "endTime",
        .image_uris = "imageUris",
        .region = "region",
        .resource_id = "resourceId",
        .snapshots = "snapshots",
        .start_time = "startTime",
        .state = "state",
    };
};
