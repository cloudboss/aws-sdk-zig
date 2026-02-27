const AwsEc2LaunchTemplateDataBlockDeviceMappingSetEbsDetails = @import("aws_ec_2_launch_template_data_block_device_mapping_set_ebs_details.zig").AwsEc2LaunchTemplateDataBlockDeviceMappingSetEbsDetails;

/// Information about a block device mapping for an Amazon Elastic Compute Cloud
/// (Amazon EC2) launch template.
pub const AwsEc2LaunchTemplateDataBlockDeviceMappingSetDetails = struct {
    /// The device name.
    device_name: ?[]const u8,

    /// Parameters used to automatically set up Amazon EBS volumes when the instance
    /// is
    /// launched.
    ebs: ?AwsEc2LaunchTemplateDataBlockDeviceMappingSetEbsDetails,

    /// Omits the device from the block device mapping when an empty string is
    /// specified.
    no_device: ?[]const u8,

    /// The virtual device name (ephemeralN). Instance store volumes are numbered
    /// starting
    /// from 0. An instance type with 2 available instance store volumes can specify
    /// mappings
    /// for `ephemeral0` and `ephemeral1`. The number of available instance store
    /// volumes depends
    /// on the instance type.
    virtual_name: ?[]const u8,

    pub const json_field_names = .{
        .device_name = "DeviceName",
        .ebs = "Ebs",
        .no_device = "NoDevice",
        .virtual_name = "VirtualName",
    };
};
