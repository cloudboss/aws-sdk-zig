const EbsVolumeConfiguration = @import("ebs_volume_configuration.zig").EbsVolumeConfiguration;

/// The configuration for a persistent volume attached to a capacity provider.
/// This structure defines the storage backing for the persistent volumes used
/// by agents that run on capacity provider instances.
pub const VolumeConfiguration = union(enum) {
    /// The configuration for an Amazon EBS-backed persistent volume.
    ebs_configuration: ?EbsVolumeConfiguration,

    pub const json_field_names = .{
        .ebs_configuration = "ebsConfiguration",
    };
};
