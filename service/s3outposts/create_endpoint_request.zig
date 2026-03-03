const EndpointAccessType = @import("endpoint_access_type.zig").EndpointAccessType;

pub const CreateEndpointRequest = struct {
    /// The type of access for the network connectivity for the Amazon S3 on
    /// Outposts endpoint. To use
    /// the Amazon Web Services VPC, choose `Private`. To use the endpoint with an
    /// on-premises
    /// network, choose `CustomerOwnedIp`. If you choose
    /// `CustomerOwnedIp`, you must also provide the customer-owned IP address
    /// pool (CoIP pool).
    ///
    /// `Private` is the default access type value.
    access_type: ?EndpointAccessType = null,

    /// The ID of the customer-owned IPv4 address pool (CoIP pool) for the endpoint.
    /// IP addresses
    /// are allocated from this pool for the endpoint.
    customer_owned_ipv_4_pool: ?[]const u8 = null,

    /// The ID of the Outposts.
    outpost_id: []const u8,

    /// The ID of the security group to use with the endpoint.
    security_group_id: []const u8,

    /// The ID of the subnet in the selected VPC. The endpoint subnet must belong to
    /// the Outpost
    /// that has Amazon S3 on Outposts provisioned.
    subnet_id: []const u8,

    pub const json_field_names = .{
        .access_type = "AccessType",
        .customer_owned_ipv_4_pool = "CustomerOwnedIpv4Pool",
        .outpost_id = "OutpostId",
        .security_group_id = "SecurityGroupId",
        .subnet_id = "SubnetId",
    };
};
