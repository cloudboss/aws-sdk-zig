const ResourceConfigurationStatus = @import("resource_configuration_status.zig").ResourceConfigurationStatus;
const ResourceConfigurationType = @import("resource_configuration_type.zig").ResourceConfigurationType;

/// Summary information about a resource configuration.
pub const ResourceConfigurationSummary = struct {
    /// Indicates whether the resource configuration was created and is managed by
    /// Amazon.
    amazon_managed: ?bool,

    /// The Amazon Resource Name (ARN) of the resource configuration.
    arn: ?[]const u8,

    /// The date and time that the resource configuration was created, in ISO-8601
    /// format.
    created_at: ?i64,

    /// The custom domain name.
    custom_domain_name: ?[]const u8,

    /// The domain verification ID.
    domain_verification_id: ?[]const u8,

    /// (GROUP) The group domain for a group resource configuration. Any domains
    /// that you create for the child resource are subdomains of the group domain.
    /// Child resources inherit the verification status of the domain.
    group_domain: ?[]const u8,

    /// The ID of the resource configuration.
    id: ?[]const u8,

    /// The most recent date and time that the resource configuration was updated,
    /// in ISO-8601 format.
    last_updated_at: ?i64,

    /// The name of the resource configuration.
    name: ?[]const u8,

    /// The ID of the group resource configuration.
    resource_configuration_group_id: ?[]const u8,

    /// The ID of the resource gateway.
    resource_gateway_id: ?[]const u8,

    /// The status of the resource configuration.
    status: ?ResourceConfigurationStatus,

    /// The type of resource configuration.
    ///
    /// * `SINGLE` - A single resource.
    /// * `GROUP` - A group of resources. You must create a group resource
    ///   configuration before you create a child resource configuration.
    /// * `CHILD` - A single resource that is part of a group resource
    ///   configuration.
    /// * `ARN` - An Amazon Web Services resource.
    @"type": ?ResourceConfigurationType,

    pub const json_field_names = .{
        .amazon_managed = "amazonManaged",
        .arn = "arn",
        .created_at = "createdAt",
        .custom_domain_name = "customDomainName",
        .domain_verification_id = "domainVerificationId",
        .group_domain = "groupDomain",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .resource_configuration_group_id = "resourceConfigurationGroupId",
        .resource_gateway_id = "resourceGatewayId",
        .status = "status",
        .@"type" = "type",
    };
};
