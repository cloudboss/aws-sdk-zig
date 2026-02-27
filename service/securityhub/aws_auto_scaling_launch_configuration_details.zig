const AwsAutoScalingLaunchConfigurationBlockDeviceMappingsDetails = @import("aws_auto_scaling_launch_configuration_block_device_mappings_details.zig").AwsAutoScalingLaunchConfigurationBlockDeviceMappingsDetails;
const AwsAutoScalingLaunchConfigurationInstanceMonitoringDetails = @import("aws_auto_scaling_launch_configuration_instance_monitoring_details.zig").AwsAutoScalingLaunchConfigurationInstanceMonitoringDetails;
const AwsAutoScalingLaunchConfigurationMetadataOptions = @import("aws_auto_scaling_launch_configuration_metadata_options.zig").AwsAutoScalingLaunchConfigurationMetadataOptions;

/// Details about a launch configuration.
pub const AwsAutoScalingLaunchConfigurationDetails = struct {
    /// For Auto Scaling groups that run in a VPC, specifies whether to assign a
    /// public IP address to the group's instances.
    associate_public_ip_address: ?bool,

    /// Specifies the block devices for the instance.
    block_device_mappings: ?[]const AwsAutoScalingLaunchConfigurationBlockDeviceMappingsDetails,

    /// The identifier of a ClassicLink-enabled VPC that EC2-Classic instances are
    /// linked to.
    classic_link_vpc_id: ?[]const u8,

    /// The identifiers of one or more security groups for the VPC that is specified
    /// in `ClassicLinkVPCId`.
    classic_link_vpc_security_groups: ?[]const []const u8,

    /// The creation date and time for the launch configuration.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    created_time: ?[]const u8,

    /// Whether the launch configuration is optimized for Amazon EBS I/O.
    ebs_optimized: ?bool,

    /// The name or the ARN of the instance profile associated with the IAM role for
    /// the
    /// instance. The instance profile contains the IAM role.
    iam_instance_profile: ?[]const u8,

    /// The identifier of the Amazon Machine Image (AMI) that is used to launch EC2
    /// instances.
    image_id: ?[]const u8,

    /// Indicates the type of monitoring for instances in the group.
    instance_monitoring: ?AwsAutoScalingLaunchConfigurationInstanceMonitoringDetails,

    /// The instance type for the instances.
    instance_type: ?[]const u8,

    /// The identifier of the kernel associated with the AMI.
    kernel_id: ?[]const u8,

    /// The name of the key pair.
    key_name: ?[]const u8,

    /// The name of the launch configuration.
    launch_configuration_name: ?[]const u8,

    /// The metadata options for the instances.
    metadata_options: ?AwsAutoScalingLaunchConfigurationMetadataOptions,

    /// The tenancy of the instance. An instance with `dedicated` tenancy runs on
    /// isolated, single-tenant hardware and can only be launched into a VPC.
    placement_tenancy: ?[]const u8,

    /// The identifier of the RAM disk associated with the AMI.
    ramdisk_id: ?[]const u8,

    /// The security groups to assign to the instances in the Amazon EC2 Auto
    /// Scaling group.
    security_groups: ?[]const []const u8,

    /// The maximum hourly price to be paid for any Spot Instance that is launched
    /// to fulfill the
    /// request.
    spot_price: ?[]const u8,

    /// The user data to make available to the launched EC2 instances. Must be
    /// base64-encoded
    /// text.
    user_data: ?[]const u8,

    pub const json_field_names = .{
        .associate_public_ip_address = "AssociatePublicIpAddress",
        .block_device_mappings = "BlockDeviceMappings",
        .classic_link_vpc_id = "ClassicLinkVpcId",
        .classic_link_vpc_security_groups = "ClassicLinkVpcSecurityGroups",
        .created_time = "CreatedTime",
        .ebs_optimized = "EbsOptimized",
        .iam_instance_profile = "IamInstanceProfile",
        .image_id = "ImageId",
        .instance_monitoring = "InstanceMonitoring",
        .instance_type = "InstanceType",
        .kernel_id = "KernelId",
        .key_name = "KeyName",
        .launch_configuration_name = "LaunchConfigurationName",
        .metadata_options = "MetadataOptions",
        .placement_tenancy = "PlacementTenancy",
        .ramdisk_id = "RamdiskId",
        .security_groups = "SecurityGroups",
        .spot_price = "SpotPrice",
        .user_data = "UserData",
    };
};
