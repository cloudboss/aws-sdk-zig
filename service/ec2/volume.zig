const VolumeAttachment = @import("volume_attachment.zig").VolumeAttachment;
const OperatorResponse = @import("operator_response.zig").OperatorResponse;
const SSEType = @import("sse_type.zig").SSEType;
const VolumeState = @import("volume_state.zig").VolumeState;
const Tag = @import("tag.zig").Tag;
const VolumeType = @import("volume_type.zig").VolumeType;

/// Describes a volume.
pub const Volume = struct {
    /// This parameter is not returned by CreateVolume.
    ///
    /// Information about the volume attachments.
    attachments: ?[]const VolumeAttachment,

    /// The Availability Zone for the volume.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone for the volume.
    availability_zone_id: ?[]const u8,

    /// The time stamp when volume creation was initiated.
    create_time: ?i64,

    /// Indicates whether the volume is encrypted.
    encrypted: ?bool,

    /// This parameter is not returned by CreateVolume.
    ///
    /// Indicates whether the volume was created using fast snapshot restore.
    fast_restored: ?bool,

    /// The number of I/O operations per second (IOPS). For `gp3`, `io1`, and `io2`
    /// volumes, this represents
    /// the number of IOPS that are provisioned for the volume. For `gp2` volumes,
    /// this represents the baseline
    /// performance of the volume and the rate at which the volume accumulates I/O
    /// credits for bursting.
    iops: ?i32,

    /// The Amazon Resource Name (ARN) of the KMS key that was used to protect the
    /// volume encryption key for the volume.
    kms_key_id: ?[]const u8,

    /// Indicates whether Amazon EBS Multi-Attach is enabled.
    multi_attach_enabled: ?bool,

    /// The service provider that manages the volume.
    operator: ?OperatorResponse,

    /// The Amazon Resource Name (ARN) of the Outpost.
    outpost_arn: ?[]const u8,

    /// The size of the volume, in GiBs.
    size: ?i32,

    /// The snapshot from which the volume was created, if applicable.
    snapshot_id: ?[]const u8,

    /// The ID of the source volume from which the volume copy was created. Only for
    /// volume copies.
    source_volume_id: ?[]const u8,

    /// This parameter is not returned by CreateVolume.
    ///
    /// Reserved for future use.
    sse_type: ?SSEType,

    /// The volume state.
    state: ?VolumeState,

    /// Any tags assigned to the volume.
    tags: ?[]const Tag,

    /// The throughput that the volume supports, in MiB/s.
    throughput: ?i32,

    /// The ID of the volume.
    volume_id: ?[]const u8,

    /// The Amazon EBS Provisioned Rate for Volume Initialization (volume
    /// initialization rate) specified for the volume during creation,
    /// in MiB/s. If no volume initialization rate was specified, the value is
    /// `null`.
    volume_initialization_rate: ?i32,

    /// The volume type.
    volume_type: ?VolumeType,
};
