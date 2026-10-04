const ArnResource = @import("arn_resource.zig").ArnResource;
const CidrResource = @import("cidr_resource.zig").CidrResource;
const DnsResource = @import("dns_resource.zig").DnsResource;
const IpResource = @import("ip_resource.zig").IpResource;

/// Describes a resource configuration.
pub const ResourceConfigurationDefinition = union(enum) {
    /// The Amazon Resource Name (ARN) of the resource.
    arn_resource: ?ArnResource,
    /// The network segment for a resource configuration of type CIDR, specified as
    /// one or more CIDR ranges (`cidrRanges`). Resources whose IP addresses fall
    /// within these ranges are reachable through a `Tunnel` VPC endpoint.
    cidr_resource: ?CidrResource,
    /// The DNS name of the resource.
    dns_resource: ?DnsResource,
    /// The IP resource.
    ip_resource: ?IpResource,

    pub const json_field_names = .{
        .arn_resource = "arnResource",
        .cidr_resource = "cidrResource",
        .dns_resource = "dnsResource",
        .ip_resource = "ipResource",
    };
};
