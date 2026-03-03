const EbsVolumeConfiguration = @import("ebs_volume_configuration.zig").EbsVolumeConfiguration;

/// Represents an Amazon EBS volume with its configuration and snapshot usage
/// information.
pub const EbsVolume = struct {
    /// The configuration details of the EBS volume, including type, size, IOPS, and
    /// throughput.
    configuration: ?EbsVolumeConfiguration = null,

    pub const json_field_names = .{
        .configuration = "configuration",
    };
};
