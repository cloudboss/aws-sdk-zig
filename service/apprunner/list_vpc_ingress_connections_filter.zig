/// Returns a list of VPC Ingress Connections based on the filter provided. It
/// can return either `ServiceArn` or `VpcEndpointId`, or both.
pub const ListVpcIngressConnectionsFilter = struct {
    /// The Amazon Resource Name (ARN) of a service to filter by.
    service_arn: ?[]const u8 = null,

    /// The ID of a VPC Endpoint to filter by.
    vpc_endpoint_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .service_arn = "ServiceArn",
        .vpc_endpoint_id = "VpcEndpointId",
    };
};
