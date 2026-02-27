const PrivateGraphEndpointStatus = @import("private_graph_endpoint_status.zig").PrivateGraphEndpointStatus;

/// Details about a private graph endpoint.
pub const PrivateGraphEndpointSummary = struct {
    /// The status of the private graph endpoint.
    status: PrivateGraphEndpointStatus,

    /// The subnet IDs associated with the private graph endpoint.
    subnet_ids: []const []const u8,

    /// The ID of the VPC endpoint.
    vpc_endpoint_id: ?[]const u8,

    /// The ID of the VPC in which the private graph endpoint is located.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .status = "status",
        .subnet_ids = "subnetIds",
        .vpc_endpoint_id = "vpcEndpointId",
        .vpc_id = "vpcId",
    };
};
