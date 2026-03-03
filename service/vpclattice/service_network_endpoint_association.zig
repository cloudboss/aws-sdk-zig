/// Describes the association between a service network and a VPC endpoint.
pub const ServiceNetworkEndpointAssociation = struct {
    /// The date and time that the association was created, in ISO-8601 format.
    created_at: ?i64 = null,

    /// The ID of the association.
    id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the service network.
    service_network_arn: ?[]const u8 = null,

    /// The state of the association.
    state: ?[]const u8 = null,

    /// The ID of the VPC endpoint associated with the service network.
    vpc_endpoint_id: ?[]const u8 = null,

    /// The owner of the VPC endpoint associated with the service network.
    vpc_endpoint_owner_id: ?[]const u8 = null,

    /// The ID of the VPC for the association.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .id = "id",
        .service_network_arn = "serviceNetworkArn",
        .state = "state",
        .vpc_endpoint_id = "vpcEndpointId",
        .vpc_endpoint_owner_id = "vpcEndpointOwnerId",
        .vpc_id = "vpcId",
    };
};
