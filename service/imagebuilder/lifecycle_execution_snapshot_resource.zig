const LifecycleExecutionResourceState = @import("lifecycle_execution_resource_state.zig").LifecycleExecutionResourceState;

/// Contains the state of an impacted snapshot resource that the runtime
/// instance of the lifecycle policy identified for action.
pub const LifecycleExecutionSnapshotResource = struct {
    /// Identifies the impacted snapshot resource.
    snapshot_id: ?[]const u8 = null,

    /// The runtime status of the lifecycle action taken for the snapshot.
    state: ?LifecycleExecutionResourceState = null,

    pub const json_field_names = .{
        .snapshot_id = "snapshotId",
        .state = "state",
    };
};
