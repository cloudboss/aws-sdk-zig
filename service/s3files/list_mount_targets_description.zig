const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;

/// Contains information about a mount target returned in list operations.
pub const ListMountTargetsDescription = struct {
    /// The Availability Zone ID where the mount target is located.
    availability_zone_id: ?[]const u8 = null,

    /// The ID of the S3 File System.
    file_system_id: ?[]const u8 = null,

    /// The IPv4 address of the mount target.
    ipv_4_address: ?[]const u8 = null,

    /// The IPv6 address of the mount target.
    ipv_6_address: ?[]const u8 = null,

    /// The ID of the mount target.
    mount_target_id: []const u8,

    /// The ID of the network interface associated with the mount target.
    network_interface_id: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the mount target owner.
    owner_id: []const u8,

    /// The current status of the mount target.
    status: ?LifeCycleState = null,

    /// Additional information about the mount target status.
    status_message: ?[]const u8 = null,

    /// The ID of the subnet where the mount target is located.
    subnet_id: []const u8,

    /// The ID of the VPC where the mount target is located.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone_id = "availabilityZoneId",
        .file_system_id = "fileSystemId",
        .ipv_4_address = "ipv4Address",
        .ipv_6_address = "ipv6Address",
        .mount_target_id = "mountTargetId",
        .network_interface_id = "networkInterfaceId",
        .owner_id = "ownerId",
        .status = "status",
        .status_message = "statusMessage",
        .subnet_id = "subnetId",
        .vpc_id = "vpcId",
    };
};
