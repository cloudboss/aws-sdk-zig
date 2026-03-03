const VolumeDetail = @import("volume_detail.zig").VolumeDetail;

/// Contains list of scanned and skipped EBS volumes with details.
pub const EbsVolumeDetails = struct {
    /// List of EBS volumes that were scanned.
    scanned_volume_details: ?[]const VolumeDetail = null,

    /// List of EBS volumes that were skipped from the malware scan.
    skipped_volume_details: ?[]const VolumeDetail = null,

    pub const json_field_names = .{
        .scanned_volume_details = "ScannedVolumeDetails",
        .skipped_volume_details = "SkippedVolumeDetails",
    };
};
