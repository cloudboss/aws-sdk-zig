/// Information about a VPC used for private connectivity, including its subnets
/// and an
/// associated VPC endpoint.
pub const VpcInformation = struct {
    /// The IDs of the subnets associated with the VPC endpoint. Currently, only one
    /// subnet is
    /// supported.
    subnet_ids: ?[]const []const u8 = null,

    /// The ID of the interface VPC endpoint for the Amazon Web Services Outposts
    /// service. When specified, the endpoint
    /// must be in the `available` state and the specified subnets must be
    /// associated with
    /// it.
    vpc_endpoint_id: ?[]const u8 = null,

    /// The ID of the VPC used for private connectivity.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .subnet_ids = "SubnetIds",
        .vpc_endpoint_id = "VpcEndpointId",
        .vpc_id = "VpcId",
    };
};
