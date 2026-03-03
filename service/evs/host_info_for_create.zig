const InstanceType = @import("instance_type.zig").InstanceType;

/// An object that represents a host.
///
/// You cannot use `dedicatedHostId` and `placementGroupId` together in the same
/// `HostInfoForCreate`object. This results in a `ValidationException` response.
pub const HostInfoForCreate = struct {
    /// The unique ID of the Amazon EC2 Dedicated Host.
    dedicated_host_id: ?[]const u8 = null,

    /// The DNS hostname of the host. DNS hostnames for hosts must be unique across
    /// Amazon EVS environments and within VCF.
    host_name: []const u8,

    /// The EC2 instance type that represents the host.
    ///
    /// Currently, Amazon EVS supports only the `i4i.metal` instance type.
    instance_type: InstanceType,

    /// The name of the SSH key that is used to access the host.
    key_name: []const u8,

    /// The unique ID of the placement group where the host is placed.
    placement_group_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .dedicated_host_id = "dedicatedHostId",
        .host_name = "hostName",
        .instance_type = "instanceType",
        .key_name = "keyName",
        .placement_group_id = "placementGroupId",
    };
};
