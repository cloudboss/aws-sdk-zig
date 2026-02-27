const InstanceBlockDeviceMapping = @import("instance_block_device_mapping.zig").InstanceBlockDeviceMapping;
const CpuOptions = @import("cpu_options.zig").CpuOptions;
const SecurityGroupIdentifier = @import("security_group_identifier.zig").SecurityGroupIdentifier;
const InstanceState = @import("instance_state.zig").InstanceState;

/// The description of an
/// instance.
/// Currently, Amazon EC2 instances are the only supported instance type.
pub const Instance = struct {
    /// The Amazon Machine Image (AMI) launch index, which you can use to find this
    /// instance in
    /// the launch group.
    ami_launch_index: ?i32,

    /// Any block device mapping entries for the instance.
    block_device_mappings: ?[]const InstanceBlockDeviceMapping,

    /// The CPU options for the instance.
    cpu_options: ?CpuOptions,

    /// When the instance was created.
    created_at: ?i64,

    /// The ID of the AMI used to launch the instance.
    image_id: ?[]const u8,

    /// The ID of the instance.
    instance_id: ?[]const u8,

    /// The instance type.
    instance_type: ?[]const u8,

    /// The private IPv4 address assigned to the instance.
    private_ip_address: ?[]const u8,

    /// The public IPv4 address assigned to the instance.
    public_ip_address: ?[]const u8,

    /// The device name of the root device volume (for example, `/dev/sda1`).
    root_device_name: ?[]const u8,

    /// The security groups for the instance.
    security_groups: ?[]const SecurityGroupIdentifier,

    state: ?InstanceState,

    /// When the instance was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .ami_launch_index = "amiLaunchIndex",
        .block_device_mappings = "blockDeviceMappings",
        .cpu_options = "cpuOptions",
        .created_at = "createdAt",
        .image_id = "imageId",
        .instance_id = "instanceId",
        .instance_type = "instanceType",
        .private_ip_address = "privateIpAddress",
        .public_ip_address = "publicIpAddress",
        .root_device_name = "rootDeviceName",
        .security_groups = "securityGroups",
        .state = "state",
        .updated_at = "updatedAt",
    };
};
