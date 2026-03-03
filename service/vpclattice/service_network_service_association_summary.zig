const DnsEntry = @import("dns_entry.zig").DnsEntry;
const ServiceNetworkServiceAssociationStatus = @import("service_network_service_association_status.zig").ServiceNetworkServiceAssociationStatus;

/// Summary information about an association between a service network and a
/// service.
pub const ServiceNetworkServiceAssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of the association.
    arn: ?[]const u8 = null,

    /// The date and time that the association was created, in ISO-8601 format.
    created_at: ?i64 = null,

    /// The account that created the association.
    created_by: ?[]const u8 = null,

    /// The custom domain name of the service.
    custom_domain_name: ?[]const u8 = null,

    /// The DNS information.
    dns_entry: ?DnsEntry = null,

    /// The ID of the association.
    id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the service.
    service_arn: ?[]const u8 = null,

    /// The ID of the service.
    service_id: ?[]const u8 = null,

    /// The name of the service.
    service_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the service network.
    service_network_arn: ?[]const u8 = null,

    /// The ID of the service network.
    service_network_id: ?[]const u8 = null,

    /// The name of the service network.
    service_network_name: ?[]const u8 = null,

    /// The status of the service network’s association with the service. If the
    /// deletion fails, try to delete again.
    status: ?ServiceNetworkServiceAssociationStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .custom_domain_name = "customDomainName",
        .dns_entry = "dnsEntry",
        .id = "id",
        .service_arn = "serviceArn",
        .service_id = "serviceId",
        .service_name = "serviceName",
        .service_network_arn = "serviceNetworkArn",
        .service_network_id = "serviceNetworkId",
        .service_network_name = "serviceNetworkName",
        .status = "status",
    };
};
