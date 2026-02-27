const EbsVolume = @import("ebs_volume.zig").EbsVolume;

/// Detailed configuration information for a specific Amazon Web Services
/// resource, with type-specific details.
pub const ResourceDetails = union(enum) {
    /// Detailed configuration information specific to EBS volumes, including volume
    /// type, size, IOPS, and throughput settings.
    ebs_volume: ?EbsVolume,

    pub const json_field_names = .{
        .ebs_volume = "ebsVolume",
    };
};
