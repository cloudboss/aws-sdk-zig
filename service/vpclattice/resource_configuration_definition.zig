const ArnResource = @import("arn_resource.zig").ArnResource;
const DnsResource = @import("dns_resource.zig").DnsResource;
const IpResource = @import("ip_resource.zig").IpResource;

/// Describes a resource configuration.
pub const ResourceConfigurationDefinition = union(enum) {
    /// The Amazon Resource Name (ARN) of the resource.
    arn_resource: ?ArnResource,
    /// The DNS name of the resource.
    dns_resource: ?DnsResource,
    /// The IP resource.
    ip_resource: ?IpResource,

    pub const json_field_names = .{
        .arn_resource = "arnResource",
        .dns_resource = "dnsResource",
        .ip_resource = "ipResource",
    };
};
