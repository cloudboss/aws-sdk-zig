const OperatorResponse = @import("operator_response.zig").OperatorResponse;
const VolumeState = @import("volume_state.zig").VolumeState;
const VolumeType = @import("volume_type.zig").VolumeType;

/// Information about a volume that is currently in the Recycle Bin.
pub const VolumeRecycleBinInfo = struct {
    /// The Availability Zone for the volume.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone for the volume.
    availability_zone_id: ?[]const u8,

    /// The time stamp when volume creation was initiated.
    create_time: ?i64,

    /// The number of I/O operations per second (IOPS) for the volume.
    iops: ?i32,

    /// The service provider that manages the volume.
    operator: ?OperatorResponse,

    /// The ARN of the Outpost on which the volume is stored. For more information,
    /// see [Amazon EBS volumes on
    /// Outposts](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-volumes-outposts.html) in the
    /// *Amazon EBS User Guide*.
    outpost_arn: ?[]const u8,

    /// The date and time when the volume entered the Recycle Bin.
    recycle_bin_enter_time: ?i64,

    /// The date and time when the volume is to be permanently deleted from the
    /// Recycle Bin.
    recycle_bin_exit_time: ?i64,

    /// The size of the volume, in GiB.
    size: ?i32,

    /// The snapshot from which the volume was created, if applicable.
    snapshot_id: ?[]const u8,

    /// The ID of the source volume.
    source_volume_id: ?[]const u8,

    /// The state of the volume.
    state: ?VolumeState,

    /// The throughput that the volume supports, in MiB/s.
    throughput: ?i32,

    /// The ID of the volume.
    volume_id: ?[]const u8,

    /// The volume type.
    volume_type: ?VolumeType,
};
