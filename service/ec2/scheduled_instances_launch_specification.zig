const ScheduledInstancesBlockDeviceMapping = @import("scheduled_instances_block_device_mapping.zig").ScheduledInstancesBlockDeviceMapping;
const ScheduledInstancesIamInstanceProfile = @import("scheduled_instances_iam_instance_profile.zig").ScheduledInstancesIamInstanceProfile;
const ScheduledInstancesMonitoring = @import("scheduled_instances_monitoring.zig").ScheduledInstancesMonitoring;
const ScheduledInstancesNetworkInterface = @import("scheduled_instances_network_interface.zig").ScheduledInstancesNetworkInterface;
const ScheduledInstancesPlacement = @import("scheduled_instances_placement.zig").ScheduledInstancesPlacement;

/// Describes the launch specification for a Scheduled Instance.
///
/// If you are launching the Scheduled Instance in EC2-VPC, you must specify the
/// ID of the subnet.
/// You can specify the subnet using either `SubnetId` or `NetworkInterface`.
pub const ScheduledInstancesLaunchSpecification = struct {
    /// The block device mapping entries.
    block_device_mappings: ?[]const ScheduledInstancesBlockDeviceMapping = null,

    /// Indicates whether the instances are optimized for EBS I/O. This optimization
    /// provides dedicated throughput to Amazon EBS and an optimized configuration
    /// stack to provide optimal EBS I/O performance. This optimization isn't
    /// available with all instance types. Additional usage charges apply when using
    /// an EBS-optimized instance.
    ///
    /// Default: `false`
    ebs_optimized: ?bool = null,

    /// The IAM instance profile.
    iam_instance_profile: ?ScheduledInstancesIamInstanceProfile = null,

    /// The ID of the Amazon Machine Image (AMI).
    image_id: []const u8,

    /// The instance type.
    instance_type: ?[]const u8 = null,

    /// The ID of the kernel.
    kernel_id: ?[]const u8 = null,

    /// The name of the key pair.
    key_name: ?[]const u8 = null,

    /// Enable or disable monitoring for the instances.
    monitoring: ?ScheduledInstancesMonitoring = null,

    /// The network interfaces.
    network_interfaces: ?[]const ScheduledInstancesNetworkInterface = null,

    /// The placement information.
    placement: ?ScheduledInstancesPlacement = null,

    /// The ID of the RAM disk.
    ramdisk_id: ?[]const u8 = null,

    /// The IDs of the security groups.
    security_group_ids: ?[]const []const u8 = null,

    /// The ID of the subnet in which to launch the instances.
    subnet_id: ?[]const u8 = null,

    /// The base64-encoded MIME user data.
    user_data: ?[]const u8 = null,
};
