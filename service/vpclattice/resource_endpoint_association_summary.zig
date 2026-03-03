/// Summary information about a VPC endpoint association.
pub const ResourceEndpointAssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of the VPC endpoint association.
    arn: ?[]const u8 = null,

    /// The date and time that the VPC endpoint association was created, in ISO-8601
    /// format.
    created_at: ?i64 = null,

    /// The account that created the association.
    created_by: ?[]const u8 = null,

    /// The ID of the VPC endpoint association.
    id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the resource configuration.
    resource_configuration_arn: ?[]const u8 = null,

    /// The ID of the resource configuration.
    resource_configuration_id: ?[]const u8 = null,

    /// The name of the resource configuration.
    resource_configuration_name: ?[]const u8 = null,

    /// The ID of the VPC endpoint.
    vpc_endpoint_id: ?[]const u8 = null,

    /// The owner of the VPC endpoint.
    vpc_endpoint_owner: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .id = "id",
        .resource_configuration_arn = "resourceConfigurationArn",
        .resource_configuration_id = "resourceConfigurationId",
        .resource_configuration_name = "resourceConfigurationName",
        .vpc_endpoint_id = "vpcEndpointId",
        .vpc_endpoint_owner = "vpcEndpointOwner",
    };
};
