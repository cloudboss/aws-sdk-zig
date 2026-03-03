const VolumeModificationState = @import("volume_modification_state.zig").VolumeModificationState;
const VolumeType = @import("volume_type.zig").VolumeType;

/// Describes the modification status of an EBS volume.
pub const VolumeModification = struct {
    /// The modification completion or failure time.
    end_time: ?i64 = null,

    /// The current modification state.
    modification_state: ?VolumeModificationState = null,

    /// The original IOPS rate of the volume.
    original_iops: ?i32 = null,

    /// The original setting for Amazon EBS Multi-Attach.
    original_multi_attach_enabled: ?bool = null,

    /// The original size of the volume, in GiB.
    original_size: ?i32 = null,

    /// The original throughput of the volume, in MiB/s.
    original_throughput: ?i32 = null,

    /// The original EBS volume type of the volume.
    original_volume_type: ?VolumeType = null,

    /// The modification progress, from 0 to 100 percent complete.
    progress: ?i64 = null,

    /// The modification start time.
    start_time: ?i64 = null,

    /// A status message about the modification progress or failure.
    status_message: ?[]const u8 = null,

    /// The target IOPS rate of the volume.
    target_iops: ?i32 = null,

    /// The target setting for Amazon EBS Multi-Attach.
    target_multi_attach_enabled: ?bool = null,

    /// The target size of the volume, in GiB.
    target_size: ?i32 = null,

    /// The target throughput of the volume, in MiB/s.
    target_throughput: ?i32 = null,

    /// The target EBS volume type of the volume.
    target_volume_type: ?VolumeType = null,

    /// The ID of the volume.
    volume_id: ?[]const u8 = null,
};
