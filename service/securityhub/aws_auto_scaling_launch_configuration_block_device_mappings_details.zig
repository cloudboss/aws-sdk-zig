const AwsAutoScalingLaunchConfigurationBlockDeviceMappingsEbsDetails = @import("aws_auto_scaling_launch_configuration_block_device_mappings_ebs_details.zig").AwsAutoScalingLaunchConfigurationBlockDeviceMappingsEbsDetails;

/// A block device for the instance.
pub const AwsAutoScalingLaunchConfigurationBlockDeviceMappingsDetails = struct {
    /// The device name that is exposed to the EC2 instance. For example, `/dev/sdh`
    /// or `xvdh`.
    device_name: ?[]const u8,

    /// Parameters that are used to automatically set up Amazon EBS volumes when an
    /// instance is launched.
    ebs: ?AwsAutoScalingLaunchConfigurationBlockDeviceMappingsEbsDetails,

    /// Whether to suppress the device that is included in the block device mapping
    /// of the Amazon Machine Image (AMI).
    ///
    /// If `NoDevice` is `true`, then you cannot specify `Ebs`.>
    no_device: ?bool,

    /// The name of the virtual device (for example, `ephemeral0`).
    ///
    /// You can provide either `VirtualName` or `Ebs`, but not both.
    virtual_name: ?[]const u8,

    pub const json_field_names = .{
        .device_name = "DeviceName",
        .ebs = "Ebs",
        .no_device = "NoDevice",
        .virtual_name = "VirtualName",
    };
};
