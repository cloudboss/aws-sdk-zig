const EbsSnapshot = @import("ebs_snapshot.zig").EbsSnapshot;
const VolumeDetail = @import("volume_detail.zig").VolumeDetail;

/// Contains additional information about a resource that was scanned.
pub const ScannedResourceDetails = struct {
    /// Contains information about the EBS snapshot that was scanned.
    ebs_snapshot: ?EbsSnapshot,

    /// Contains information about the EBS volume that was scanned.
    ebs_volume: ?VolumeDetail,

    pub const json_field_names = .{
        .ebs_snapshot = "EbsSnapshot",
        .ebs_volume = "EbsVolume",
    };
};
