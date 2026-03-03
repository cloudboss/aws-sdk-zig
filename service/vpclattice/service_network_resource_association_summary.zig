const DnsEntry = @import("dns_entry.zig").DnsEntry;
const ServiceNetworkResourceAssociationStatus = @import("service_network_resource_association_status.zig").ServiceNetworkResourceAssociationStatus;

/// Summary information about an association between a service network and a
/// resource configuration.
pub const ServiceNetworkResourceAssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of the association.
    arn: ?[]const u8 = null,

    /// The date and time that the association was created, in ISO-8601 format.
    created_at: ?i64 = null,

    /// The account that created the association.
    created_by: ?[]const u8 = null,

    /// The DNS entry for the service.
    dns_entry: ?DnsEntry = null,

    /// The failure code.
    failure_code: ?[]const u8 = null,

    /// The ID of the association between the service network and resource
    /// configuration.
    id: ?[]const u8 = null,

    /// Specifies whether the association is managed by Amazon.
    is_managed_association: ?bool = null,

    /// Indicates if private DNS is enabled for the service network resource
    /// association.
    private_dns_enabled: ?bool = null,

    /// The private DNS entry for the service.
    private_dns_entry: ?DnsEntry = null,

    /// The Amazon Resource Name (ARN) of the association.
    resource_configuration_arn: ?[]const u8 = null,

    /// The ID of the resource configuration associated with the service network.
    resource_configuration_id: ?[]const u8 = null,

    /// The name of the resource configuration associated with the service network.
    resource_configuration_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the service network associated with the
    /// resource configuration.
    service_network_arn: ?[]const u8 = null,

    /// The ID of the service network associated with the resource configuration.
    service_network_id: ?[]const u8 = null,

    /// The name of the service network associated with the resource configuration.
    service_network_name: ?[]const u8 = null,

    /// The status of the service network’s association with the resource
    /// configuration. If the deletion fails, try to delete again.
    status: ?ServiceNetworkResourceAssociationStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .dns_entry = "dnsEntry",
        .failure_code = "failureCode",
        .id = "id",
        .is_managed_association = "isManagedAssociation",
        .private_dns_enabled = "privateDnsEnabled",
        .private_dns_entry = "privateDnsEntry",
        .resource_configuration_arn = "resourceConfigurationArn",
        .resource_configuration_id = "resourceConfigurationId",
        .resource_configuration_name = "resourceConfigurationName",
        .service_network_arn = "serviceNetworkArn",
        .service_network_id = "serviceNetworkId",
        .service_network_name = "serviceNetworkName",
        .status = "status",
    };
};
