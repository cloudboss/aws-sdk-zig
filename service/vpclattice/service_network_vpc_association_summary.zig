const DnsOptions = @import("dns_options.zig").DnsOptions;
const ServiceNetworkVpcAssociationStatus = @import("service_network_vpc_association_status.zig").ServiceNetworkVpcAssociationStatus;

/// Summary information about an association between a service network and a
/// VPC.
pub const ServiceNetworkVpcAssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of the association.
    arn: ?[]const u8 = null,

    /// The date and time that the association was created, in ISO-8601 format.
    created_at: ?i64 = null,

    /// The account that created the association.
    created_by: ?[]const u8 = null,

    /// The DNS options for the service network VPC association.
    dns_options: ?DnsOptions = null,

    /// The ID of the association.
    id: ?[]const u8 = null,

    /// The date and time that the association was last updated, in ISO-8601 format.
    last_updated_at: ?i64 = null,

    /// Indicates if private DNS is enabled for the service network VPC association.
    private_dns_enabled: ?bool = null,

    /// The Amazon Resource Name (ARN) of the service network.
    service_network_arn: ?[]const u8 = null,

    /// The ID of the service network.
    service_network_id: ?[]const u8 = null,

    /// The name of the service network.
    service_network_name: ?[]const u8 = null,

    /// The status.
    status: ?ServiceNetworkVpcAssociationStatus = null,

    /// The ID of the VPC.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .dns_options = "dnsOptions",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .private_dns_enabled = "privateDnsEnabled",
        .service_network_arn = "serviceNetworkArn",
        .service_network_id = "serviceNetworkId",
        .service_network_name = "serviceNetworkName",
        .status = "status",
        .vpc_id = "vpcId",
    };
};
