const AdministrativeAction = @import("administrative_action.zig").AdministrativeAction;
const SnapshotLifecycle = @import("snapshot_lifecycle.zig").SnapshotLifecycle;
const LifecycleTransitionReason = @import("lifecycle_transition_reason.zig").LifecycleTransitionReason;
const Tag = @import("tag.zig").Tag;

/// A snapshot of an Amazon FSx for OpenZFS volume.
pub const Snapshot = struct {
    /// A list of administrative actions for the file system that are in process or
    /// waiting to
    /// be processed. Administrative actions describe changes to the Amazon FSx
    /// system.
    administrative_actions: ?[]const AdministrativeAction = null,

    creation_time: ?i64 = null,

    /// The lifecycle status of the snapshot.
    ///
    /// * `PENDING` - Amazon FSx hasn't started creating the
    /// snapshot.
    ///
    /// * `CREATING` - Amazon FSx is creating the snapshot.
    ///
    /// * `DELETING` - Amazon FSx is deleting the snapshot.
    ///
    /// * `AVAILABLE` - The snapshot is fully available.
    lifecycle: ?SnapshotLifecycle = null,

    lifecycle_transition_reason: ?LifecycleTransitionReason = null,

    /// The name of the snapshot.
    name: ?[]const u8 = null,

    resource_arn: ?[]const u8 = null,

    /// The ID of the snapshot.
    snapshot_id: ?[]const u8 = null,

    tags: ?[]const Tag = null,

    /// The ID of the volume that the snapshot is of.
    volume_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .administrative_actions = "AdministrativeActions",
        .creation_time = "CreationTime",
        .lifecycle = "Lifecycle",
        .lifecycle_transition_reason = "LifecycleTransitionReason",
        .name = "Name",
        .resource_arn = "ResourceARN",
        .snapshot_id = "SnapshotId",
        .tags = "Tags",
        .volume_id = "VolumeId",
    };
};
