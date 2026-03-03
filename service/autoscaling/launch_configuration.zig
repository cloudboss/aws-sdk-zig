const BlockDeviceMapping = @import("block_device_mapping.zig").BlockDeviceMapping;
const InstanceMonitoring = @import("instance_monitoring.zig").InstanceMonitoring;
const InstanceMetadataOptions = @import("instance_metadata_options.zig").InstanceMetadataOptions;

/// Describes a launch configuration.
pub const LaunchConfiguration = struct {
    /// Specifies whether to assign a public IPv4 address to the group's instances.
    /// If the
    /// instance is launched into a default subnet, the default is to assign a
    /// public IPv4
    /// address, unless you disabled the option to assign a public IPv4 address on
    /// the subnet.
    /// If the instance is launched into a nondefault subnet, the default is not to
    /// assign a
    /// public IPv4 address, unless you enabled the option to assign a public IPv4
    /// address on
    /// the subnet. For more information, see [Provide network connectivity for
    /// your Auto Scaling instances using Amazon
    /// VPC](https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-in-vpc.html)
    /// in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    associate_public_ip_address: ?bool = null,

    /// The block device mapping entries that define the block devices to attach to
    /// the
    /// instances at launch. By default, the block devices specified in the block
    /// device mapping
    /// for the AMI are used. For more information, see [Block device
    /// mappings](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html) in the *Amazon EC2 User Guide*.
    block_device_mappings: ?[]const BlockDeviceMapping = null,

    /// Available for backward compatibility.
    classic_link_vpc_id: ?[]const u8 = null,

    /// Available for backward compatibility.
    classic_link_vpc_security_groups: ?[]const []const u8 = null,

    /// The creation date and time for the launch configuration.
    created_time: i64,

    /// Specifies whether the launch configuration is optimized for EBS I/O
    /// (`true`) or not (`false`). For more information, see [Amazon EBS-optimized
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html) in the
    /// *Amazon EC2 User Guide*.
    ebs_optimized: ?bool = null,

    /// The name or the Amazon Resource Name (ARN) of the instance profile
    /// associated with the
    /// IAM role for the instance. The instance profile contains the IAM role. For
    /// more
    /// information, see [IAM role for applications that run
    /// on Amazon EC2
    /// instances](https://docs.aws.amazon.com/autoscaling/ec2/userguide/us-iam-role.html) in the *Amazon EC2 Auto Scaling User Guide*.
    iam_instance_profile: ?[]const u8 = null,

    /// The ID of the Amazon Machine Image (AMI) to use to launch your EC2
    /// instances. For more
    /// information, see [Find a Linux
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html) in the
    /// *Amazon EC2 User Guide*.
    image_id: []const u8,

    /// Controls whether instances in this group are launched with detailed
    /// (`true`) or basic (`false`) monitoring.
    ///
    /// For more information, see [Configure
    /// monitoring for Auto Scaling
    /// instances](https://docs.aws.amazon.com/autoscaling/latest/userguide/enable-as-instance-metrics.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    instance_monitoring: ?InstanceMonitoring = null,

    /// The instance type for the instances. For information about available
    /// instance types,
    /// see [Available
    /// instance
    /// types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#AvailableInstanceTypes) in the *Amazon EC2 User Guide*.
    instance_type: []const u8,

    /// The ID of the kernel associated with the AMI.
    kernel_id: ?[]const u8 = null,

    /// The name of the key pair.
    ///
    /// For more information, see [Amazon EC2 key pairs and Amazon EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) in the *Amazon EC2 User Guide*.
    key_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the launch configuration.
    launch_configuration_arn: ?[]const u8 = null,

    /// The name of the launch configuration.
    launch_configuration_name: []const u8,

    /// The metadata options for the instances. For more information, see [Configure
    /// the instance metadata
    /// options](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-launch-config.html#launch-configurations-imds) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    metadata_options: ?InstanceMetadataOptions = null,

    /// The tenancy of the instance, either `default` or `dedicated`. An
    /// instance with `dedicated` tenancy runs on isolated, single-tenant hardware
    /// and can only be launched into a VPC.
    placement_tenancy: ?[]const u8 = null,

    /// The ID of the RAM disk associated with the AMI.
    ramdisk_id: ?[]const u8 = null,

    /// A list that contains the security groups to assign to the instances in the
    /// Auto Scaling group.
    /// For more information, see [Control traffic to your Amazon Web Services
    /// resources using security
    /// groups](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html) in the *Amazon Virtual Private
    /// Cloud User Guide*.
    security_groups: ?[]const []const u8 = null,

    /// The maximum hourly price to be paid for any Spot Instance launched to
    /// fulfill the
    /// request. Spot Instances are launched when the price you specify exceeds the
    /// current Spot
    /// price. For more information, see [Requesting Spot
    /// Instances for fault-tolerant and flexible
    /// applications](https://docs.aws.amazon.com/autoscaling/ec2/userguide/launch-template-spot-instances.html) in the *Amazon EC2 Auto Scaling User Guide*.
    spot_price: ?[]const u8 = null,

    /// The user data to make available to the launched EC2 instances. For more
    /// information,
    /// see [Instance metadata and user
    /// data](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html) in the *Amazon EC2 User Guide*.
    /// If you are using a command line tool, base64-encoding
    /// is performed for you, and you can load the text from a file. Otherwise, you
    /// must provide
    /// base64-encoded text. User data is limited to 16 KB.
    user_data: ?[]const u8 = null,
};
