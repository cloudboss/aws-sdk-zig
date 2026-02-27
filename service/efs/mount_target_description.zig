const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;

/// Provides a description of a mount target.
pub const MountTargetDescription = struct {
    /// The unique and consistent identifier of the Availability Zone that the mount
    /// target resides in.
    /// For example, `use1-az1` is an AZ ID for the us-east-1 Region and it
    /// has the same location in every Amazon Web Services account.
    availability_zone_id: ?[]const u8,

    /// The name of the Availability Zone in which the mount target is located.
    /// Availability Zones are
    /// independently mapped to names for each Amazon Web Services account. For
    /// example, the
    /// Availability Zone `us-east-1a` for your Amazon Web Services account might
    /// not be the
    /// same location as `us-east-1a` for another Amazon Web Services account.
    availability_zone_name: ?[]const u8,

    /// The ID of the file system for which the mount target is intended.
    file_system_id: []const u8,

    /// Address at which the file system can be mounted by using the mount target.
    ip_address: ?[]const u8,

    /// The IPv6 address for the mount target.
    ipv_6_address: ?[]const u8,

    /// Lifecycle state of the mount target.
    life_cycle_state: LifeCycleState,

    /// System-assigned mount target ID.
    mount_target_id: []const u8,

    /// The ID of the network interface that Amazon EFS created when it created the
    /// mount
    /// target.
    network_interface_id: ?[]const u8,

    /// Amazon Web Services account ID that owns the resource.
    owner_id: ?[]const u8,

    /// The ID of the mount target's subnet.
    subnet_id: []const u8,

    /// The virtual private cloud (VPC) ID that the mount target is configured in.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .availability_zone_id = "AvailabilityZoneId",
        .availability_zone_name = "AvailabilityZoneName",
        .file_system_id = "FileSystemId",
        .ip_address = "IpAddress",
        .ipv_6_address = "Ipv6Address",
        .life_cycle_state = "LifeCycleState",
        .mount_target_id = "MountTargetId",
        .network_interface_id = "NetworkInterfaceId",
        .owner_id = "OwnerId",
        .subnet_id = "SubnetId",
        .vpc_id = "VpcId",
    };
};
