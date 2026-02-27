const EbsBlockDeviceConfig = @import("ebs_block_device_config.zig").EbsBlockDeviceConfig;

/// The Amazon EBS configuration of a cluster instance.
pub const EbsConfiguration = struct {
    /// An array of Amazon EBS volume specifications attached to a cluster
    /// instance.
    ebs_block_device_configs: ?[]const EbsBlockDeviceConfig,

    /// Indicates whether an Amazon EBS volume is EBS-optimized. The default is
    /// false. You should explicitly set this value to true to enable the Amazon
    /// EBS-optimized setting
    /// for an EC2 instance.
    ebs_optimized: ?bool,

    pub const json_field_names = .{
        .ebs_block_device_configs = "EbsBlockDeviceConfigs",
        .ebs_optimized = "EbsOptimized",
    };
};
