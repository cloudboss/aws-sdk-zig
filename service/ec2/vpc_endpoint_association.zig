const DnsEntry = @import("dns_entry.zig").DnsEntry;
const Tag = @import("tag.zig").Tag;

/// Describes the VPC resources, VPC endpoint services, Lattice services, or
/// service
/// networks associated with the VPC endpoint.
pub const VpcEndpointAssociation = struct {
    /// The connectivity status of the resources associated to a VPC endpoint. The
    /// resource is
    /// accessible if the associated resource configuration is `AVAILABLE`,
    /// otherwise
    /// the resource is inaccessible.
    associated_resource_accessibility: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the associated resource.
    associated_resource_arn: ?[]const u8,

    /// The DNS entry of the VPC endpoint association.
    dns_entry: ?DnsEntry,

    /// An error code related to why an VPC endpoint association failed.
    failure_code: ?[]const u8,

    /// A message related to why an VPC endpoint association failed.
    failure_reason: ?[]const u8,

    /// The ID of the VPC endpoint association.
    id: ?[]const u8,

    /// The private DNS entry of the VPC endpoint association.
    private_dns_entry: ?DnsEntry,

    /// The Amazon Resource Name (ARN) of the resource configuration group.
    resource_configuration_group_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the service network.
    service_network_arn: ?[]const u8,

    /// The name of the service network.
    service_network_name: ?[]const u8,

    /// The tags to apply to the VPC endpoint association.
    tags: ?[]const Tag,

    /// The ID of the VPC endpoint.
    vpc_endpoint_id: ?[]const u8,
};
