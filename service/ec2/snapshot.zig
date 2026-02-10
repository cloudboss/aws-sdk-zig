const SSEType = @import("sse_type.zig").SSEType;
const SnapshotState = @import("snapshot_state.zig").SnapshotState;
const StorageTier = @import("storage_tier.zig").StorageTier;
const Tag = @import("tag.zig").Tag;
const TransferType = @import("transfer_type.zig").TransferType;

/// Describes a snapshot.
pub const Snapshot = struct {
    /// The Availability Zone or Local Zone of the snapshot. For example,
    /// `us-west-1a`
    /// (Availability Zone) or `us-west-2-lax-1a` (Local Zone).
    availability_zone: ?[]const u8,

    /// **Note:**
    ///
    /// Only for snapshot copies created with time-based snapshot copy operations.
    ///
    /// The completion duration requested for the time-based snapshot copy
    /// operation.
    completion_duration_minutes: ?i32,

    /// The time stamp when the snapshot was completed.
    completion_time: ?i64,

    /// The data encryption key identifier for the snapshot. This value is a unique
    /// identifier
    /// that corresponds to the data encryption key that was used to encrypt the
    /// original volume or
    /// snapshot copy. Because data encryption keys are inherited by volumes created
    /// from snapshots,
    /// and vice versa, if snapshots share the same data encryption key identifier,
    /// then they belong
    /// to the same volume/snapshot lineage. This parameter is only returned by
    /// DescribeSnapshots.
    data_encryption_key_id: ?[]const u8,

    /// The description for the snapshot.
    description: ?[]const u8,

    /// Indicates whether the snapshot is encrypted.
    encrypted: ?bool,

    /// The full size of the snapshot, in bytes.
    ///
    /// **Important:**
    ///
    /// This is **not** the incremental size of the snapshot.
    /// This is the full snapshot size and represents the size of all the blocks
    /// that were
    /// written to the source volume at the time the snapshot was created.
    full_snapshot_size_in_bytes: ?i64,

    /// The Amazon Resource Name (ARN) of the KMS key that was used to protect the
    /// volume encryption key for the parent volume.
    kms_key_id: ?[]const u8,

    /// The ARN of the Outpost on which the snapshot is stored. For more
    /// information, see [Amazon EBS local snapshots on
    /// Outposts](https://docs.aws.amazon.com/ebs/latest/userguide/snapshots-outposts.html) in the
    /// *Amazon EBS User Guide*.
    outpost_arn: ?[]const u8,

    /// The Amazon Web Services owner alias, from an Amazon-maintained list
    /// (`amazon`). This is not
    /// the user-configured Amazon Web Services account alias set using the IAM
    /// console.
    owner_alias: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the EBS snapshot.
    owner_id: ?[]const u8,

    /// The progress of the snapshot, as a percentage.
    progress: ?[]const u8,

    /// Only for archived snapshots that are temporarily restored. Indicates the
    /// date and
    /// time when a temporarily restored snapshot will be automatically re-archived.
    restore_expiry_time: ?i64,

    /// The ID of the snapshot. Each snapshot receives a unique identifier when it
    /// is
    /// created.
    snapshot_id: ?[]const u8,

    /// Reserved for future use.
    sse_type: ?SSEType,

    /// The time stamp when the snapshot was initiated.
    start_time: ?i64,

    /// The snapshot state.
    state: ?SnapshotState,

    /// Encrypted Amazon EBS snapshots are copied asynchronously. If a snapshot copy
    /// operation fails
    /// (for example, if the proper KMS permissions are not obtained) this field
    /// displays error
    /// state details to help you diagnose why the error occurred. This parameter is
    /// only returned by
    /// DescribeSnapshots.
    state_message: ?[]const u8,

    /// The storage tier in which the snapshot is stored. `standard` indicates
    /// that the snapshot is stored in the standard snapshot storage tier and that
    /// it is ready
    /// for use. `archive` indicates that the snapshot is currently archived and
    /// that
    /// it must be restored before it can be used.
    storage_tier: ?StorageTier,

    /// Any tags assigned to the snapshot.
    tags: ?[]const Tag,

    /// **Note:**
    ///
    /// Only for snapshot copies.
    ///
    /// Indicates whether the snapshot copy was created with a standard or
    /// time-based
    /// snapshot copy operation. Time-based snapshot copy operations complete within
    /// the
    /// completion duration specified in the request. Standard snapshot copy
    /// operations
    /// are completed on a best-effort basis.
    ///
    /// * `standard` - The snapshot copy was created with a standard
    /// snapshot copy operation.
    ///
    /// * `time-based` - The snapshot copy was created with a time-based
    /// snapshot copy operation.
    transfer_type: ?TransferType,

    /// The ID of the volume that was used to create the snapshot. Snapshots created
    /// by a copy
    /// snapshot operation have an arbitrary volume ID that you should not use for
    /// any purpose.
    volume_id: ?[]const u8,

    /// The size of the volume, in GiB.
    volume_size: ?i32,
};
