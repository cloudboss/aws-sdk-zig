const BlockDeviceMapping = @import("block_device_mapping.zig").BlockDeviceMapping;
const IamInstanceProfileSpecification = @import("iam_instance_profile_specification.zig").IamInstanceProfileSpecification;
const InstanceRequirements = @import("instance_requirements.zig").InstanceRequirements;
const InstanceType = @import("instance_type.zig").InstanceType;
const SpotFleetMonitoring = @import("spot_fleet_monitoring.zig").SpotFleetMonitoring;
const InstanceNetworkInterfaceSpecification = @import("instance_network_interface_specification.zig").InstanceNetworkInterfaceSpecification;
const SpotPlacement = @import("spot_placement.zig").SpotPlacement;
const GroupIdentifier = @import("group_identifier.zig").GroupIdentifier;
const SpotFleetTagSpecification = @import("spot_fleet_tag_specification.zig").SpotFleetTagSpecification;

/// Describes the launch specification for one or more Spot Instances. If you
/// include
/// On-Demand capacity in your fleet request or want to specify an EFA network
/// device, you
/// can't use `SpotFleetLaunchSpecification`; you must use
/// [LaunchTemplateConfig](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_LaunchTemplateConfig.html).
pub const SpotFleetLaunchSpecification = struct {
    /// Deprecated.
    addressing_type: ?[]const u8,

    /// One or more block devices that are mapped to the Spot Instances. You can't
    /// specify both
    /// a snapshot ID and an encryption value. This is because only blank volumes
    /// can be
    /// encrypted on creation. If a snapshot is the basis for a volume, it is not
    /// blank and its
    /// encryption status is used for the volume encryption status.
    block_device_mappings: ?[]const BlockDeviceMapping,

    /// Indicates whether the instances are optimized for EBS I/O. This optimization
    /// provides dedicated throughput to Amazon EBS and an optimized configuration
    /// stack to provide optimal EBS I/O performance. This optimization isn't
    /// available with all instance types. Additional usage charges apply when using
    /// an EBS Optimized instance.
    ///
    /// Default: `false`
    ebs_optimized: ?bool,

    /// The IAM instance profile.
    iam_instance_profile: ?IamInstanceProfileSpecification,

    /// The ID of the AMI.
    image_id: ?[]const u8,

    /// The attributes for the instance types. When you specify instance attributes,
    /// Amazon EC2 will
    /// identify instance types with those attributes.
    ///
    /// **Note:**
    ///
    /// If you specify `InstanceRequirements`, you can't specify
    /// `InstanceType`.
    instance_requirements: ?InstanceRequirements,

    /// The instance type.
    instance_type: ?InstanceType,

    /// The ID of the kernel.
    kernel_id: ?[]const u8,

    /// The name of the key pair.
    key_name: ?[]const u8,

    /// Enable or disable monitoring for the instances.
    monitoring: ?SpotFleetMonitoring,

    /// The network interfaces.
    ///
    /// **Note:**
    ///
    /// `SpotFleetLaunchSpecification` does not support Elastic Fabric Adapter
    /// (EFA).
    /// You must use
    /// [LaunchTemplateConfig](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_LaunchTemplateConfig.html) instead.
    network_interfaces: ?[]const InstanceNetworkInterfaceSpecification,

    /// The placement information.
    placement: ?SpotPlacement,

    /// The ID of the RAM disk. Some kernels require additional drivers at launch.
    /// Check the kernel
    /// requirements for information about whether you need to specify a RAM disk.
    /// To find kernel
    /// requirements, refer to the Amazon Web Services Resource Center and search
    /// for the kernel ID.
    ramdisk_id: ?[]const u8,

    /// The security groups.
    ///
    /// If you specify a network interface, you must specify any security groups as
    /// part of
    /// the network interface instead of using this parameter.
    security_groups: ?[]const GroupIdentifier,

    /// The maximum price per unit hour that you are willing to pay for a Spot
    /// Instance. We do not recommend using this parameter because it can lead to
    /// increased interruptions. If you do not specify this parameter, you will pay
    /// the current Spot price.
    ///
    /// **Important:**
    ///
    /// If you specify a maximum price, your instances will be interrupted more
    /// frequently than if you do not specify this parameter.
    spot_price: ?[]const u8,

    /// The IDs of the subnets in which to launch the instances. To specify multiple
    /// subnets, separate
    /// them using commas; for example, "subnet-1234abcdeexample1,
    /// subnet-0987cdef6example2".
    ///
    /// If you specify a network interface, you must specify any subnets as part of
    /// the
    /// network interface instead of using this parameter.
    subnet_id: ?[]const u8,

    /// The tags to apply during creation.
    tag_specifications: ?[]const SpotFleetTagSpecification,

    /// The base64-encoded user data that instances use when starting up. User data
    /// is limited to 16 KB.
    user_data: ?[]const u8,

    /// The number of units provided by the specified instance type. These are the
    /// same units
    /// that you chose to set the target capacity in terms of instances, or a
    /// performance
    /// characteristic such as vCPUs, memory, or I/O.
    ///
    /// If the target capacity divided by this value is not a whole number, Amazon
    /// EC2 rounds the
    /// number of instances to the next whole number. If this value is not
    /// specified, the default
    /// is 1.
    ///
    /// **Note:**
    ///
    /// When specifying weights, the price used in the `lowestPrice` and
    /// `priceCapacityOptimized` allocation strategies is per
    /// *unit* hour (where the instance price is divided by the specified
    /// weight). However, if all the specified weights are above the requested
    /// `TargetCapacity`, resulting in only 1 instance being launched, the price
    /// used is per *instance* hour.
    weighted_capacity: ?f64,
};
