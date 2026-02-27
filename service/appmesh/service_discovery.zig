const AwsCloudMapServiceDiscovery = @import("aws_cloud_map_service_discovery.zig").AwsCloudMapServiceDiscovery;
const DnsServiceDiscovery = @import("dns_service_discovery.zig").DnsServiceDiscovery;

/// An object that represents the service discovery information for a virtual
/// node.
pub const ServiceDiscovery = union(enum) {
    /// Specifies any Cloud Map information for the virtual node.
    aws_cloud_map: ?AwsCloudMapServiceDiscovery,
    /// Specifies the DNS information for the virtual node.
    dns: ?DnsServiceDiscovery,

    pub const json_field_names = .{
        .aws_cloud_map = "awsCloudMap",
        .dns = "dns",
    };
};
