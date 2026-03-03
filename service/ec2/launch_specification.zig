const BlockDeviceMapping = @import("block_device_mapping.zig").BlockDeviceMapping;
const IamInstanceProfileSpecification = @import("iam_instance_profile_specification.zig").IamInstanceProfileSpecification;
const InstanceType = @import("instance_type.zig").InstanceType;
const RunInstancesMonitoringEnabled = @import("run_instances_monitoring_enabled.zig").RunInstancesMonitoringEnabled;
const InstanceNetworkInterfaceSpecification = @import("instance_network_interface_specification.zig").InstanceNetworkInterfaceSpecification;
const SpotPlacement = @import("spot_placement.zig").SpotPlacement;
const GroupIdentifier = @import("group_identifier.zig").GroupIdentifier;

/// Describes the launch specification for an instance.
pub const LaunchSpecification = struct {
    /// Deprecated.
    addressing_type: ?[]const u8 = null,

    /// The block device mapping entries.
    block_device_mappings: ?[]const BlockDeviceMapping = null,

    /// Indicates whether the instance is optimized for EBS I/O. This optimization
    /// provides dedicated throughput to Amazon EBS and an optimized configuration
    /// stack to provide optimal EBS I/O performance. This optimization isn't
    /// available with all instance types. Additional usage charges apply when using
    /// an EBS Optimized instance.
    ///
    /// Default: `false`
    ebs_optimized: ?bool = null,

    /// The IAM instance profile.
    iam_instance_profile: ?IamInstanceProfileSpecification = null,

    /// The ID of the AMI.
    image_id: ?[]const u8 = null,

    /// The instance type. Only one instance type can be specified.
    instance_type: ?InstanceType = null,

    /// The ID of the kernel.
    kernel_id: ?[]const u8 = null,

    /// The name of the key pair.
    key_name: ?[]const u8 = null,

    monitoring: ?RunInstancesMonitoringEnabled = null,

    /// The network interfaces. If you specify a network interface, you must specify
    /// subnet IDs and security group IDs using the network interface.
    network_interfaces: ?[]const InstanceNetworkInterfaceSpecification = null,

    /// The placement information for the instance.
    placement: ?SpotPlacement = null,

    /// The ID of the RAM disk.
    ramdisk_id: ?[]const u8 = null,

    /// The IDs of the security groups.
    security_groups: ?[]const GroupIdentifier = null,

    /// The ID of the subnet in which to launch the instance.
    subnet_id: ?[]const u8 = null,

    /// The base64-encoded user data that instances use when starting up. User data
    /// is limited to 16 KB.
    user_data: ?[]const u8 = null,
};
