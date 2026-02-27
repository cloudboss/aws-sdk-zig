const HostState = @import("host_state.zig").HostState;
const InstanceType = @import("instance_type.zig").InstanceType;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;

/// An ESX host that runs on an Amazon EC2 bare metal instance. Four hosts are
/// created in an Amazon EVS environment during environment creation. You can
/// add hosts to an environment using the `CreateEnvironmentHost` operation.
/// Amazon EVS supports 4-16 hosts per environment.
pub const Host = struct {
    /// The date and time that the host was created.
    created_at: ?i64,

    /// The unique ID of the Amazon EC2 Dedicated Host.
    dedicated_host_id: ?[]const u8,

    /// The unique ID of the EC2 instance that represents the host.
    ec_2_instance_id: ?[]const u8,

    /// The DNS hostname of the host. DNS hostnames for hosts must be unique across
    /// Amazon EVS environments and within VCF.
    host_name: ?[]const u8,

    /// The state of the host.
    host_state: ?HostState,

    /// The EC2 instance type of the host.
    ///
    /// Currently, Amazon EVS supports only the `i4i.metal` instance type.
    ///
    /// EC2 instances created through Amazon EVS do not support associating an IAM
    /// instance profile.
    instance_type: ?InstanceType,

    /// The IP address of the host.
    ip_address: ?[]const u8,

    /// The name of the SSH key that is used to access the host.
    key_name: ?[]const u8,

    /// The date and time that the host was modified.
    modified_at: ?i64,

    /// The elastic network interfaces that are attached to the host.
    network_interfaces: ?[]const NetworkInterface,

    /// The unique ID of the placement group where the host is placed.
    placement_group_id: ?[]const u8,

    /// A detailed description of the `hostState` of a host.
    state_details: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .dedicated_host_id = "dedicatedHostId",
        .ec_2_instance_id = "ec2InstanceId",
        .host_name = "hostName",
        .host_state = "hostState",
        .instance_type = "instanceType",
        .ip_address = "ipAddress",
        .key_name = "keyName",
        .modified_at = "modifiedAt",
        .network_interfaces = "networkInterfaces",
        .placement_group_id = "placementGroupId",
        .state_details = "stateDetails",
    };
};
