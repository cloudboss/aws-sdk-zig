/// Details of a resource created and managed by the gateway for private
/// endpoint connectivity.
pub const ManagedResourceDetails = struct {
    /// The domain associated with this managed resource.
    domain: ?[]const u8 = null,

    /// The ARN of the service network resource association.
    resource_association_arn: ?[]const u8 = null,

    /// The ARN of the VPC Lattice resource gateway created in your account.
    resource_gateway_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain = "domain",
        .resource_association_arn = "resourceAssociationArn",
        .resource_gateway_arn = "resourceGatewayArn",
    };
};
