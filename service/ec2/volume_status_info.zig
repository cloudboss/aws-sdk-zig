const VolumeStatusDetails = @import("volume_status_details.zig").VolumeStatusDetails;
const VolumeStatusInfoStatus = @import("volume_status_info_status.zig").VolumeStatusInfoStatus;

/// Describes the status of a volume.
pub const VolumeStatusInfo = struct {
    /// The details of the volume status.
    details: ?[]const VolumeStatusDetails = null,

    /// The status of the volume.
    status: ?VolumeStatusInfoStatus = null,
};
