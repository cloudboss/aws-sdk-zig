const SSEType = @import("sse_type.zig").SSEType;
const SnapshotState = @import("snapshot_state.zig").SnapshotState;
const Tag = @import("tag.zig").Tag;

/// Information about a snapshot.
pub const SnapshotInfo = struct {
    /// The Availability Zone or Local Zone of the snapshots. For example,
    /// `us-west-1a`
    /// (Availability Zone) or `us-west-2-lax-1a` (Local Zone).
    availability_zone: ?[]const u8,

    /// Description specified by the CreateSnapshotRequest that has been applied to
    /// all
    /// snapshots.
    description: ?[]const u8,

    /// Indicates whether the snapshot is encrypted.
    encrypted: ?bool,

    /// The ARN of the Outpost on which the snapshot is stored. For more
    /// information, see [Amazon EBS local snapshots on
    /// Outposts](https://docs.aws.amazon.com/ebs/latest/userguide/snapshots-outposts.html) in the
    /// *Amazon EBS User Guide*.
    outpost_arn: ?[]const u8,

    /// Account id used when creating this snapshot.
    owner_id: ?[]const u8,

    /// Progress this snapshot has made towards completing.
    progress: ?[]const u8,

    /// Snapshot id that can be used to describe this snapshot.
    snapshot_id: ?[]const u8,

    /// Reserved for future use.
    sse_type: ?SSEType,

    /// Time this snapshot was started. This is the same for all snapshots initiated
    /// by the
    /// same request.
    start_time: ?i64,

    /// Current state of the snapshot.
    state: ?SnapshotState,

    /// Tags associated with this snapshot.
    tags: ?[]const Tag,

    /// Source volume from which this snapshot was created.
    volume_id: ?[]const u8,

    /// Size of the volume from which this snapshot was created.
    volume_size: ?i32,
};
