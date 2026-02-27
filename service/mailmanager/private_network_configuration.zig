/// Specifies the network configuration for the private ingress point.
pub const PrivateNetworkConfiguration = struct {
    /// The identifier of the VPC endpoint to associate with this private ingress
    /// point.
    vpc_endpoint_id: []const u8,

    pub const json_field_names = .{
        .vpc_endpoint_id = "VpcEndpointId",
    };
};
