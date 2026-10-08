const ResourceConfigDnsResolution = @import("resource_config_dns_resolution.zig").ResourceConfigDnsResolution;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;

/// Configuration for a service-managed Private Connection.
pub const ServiceManagedInput = struct {
    /// Certificate for the Private Connection.
    certificate: ?[]const u8 = null,

    /// DNS resolution mode for the resource gateway. Defaults to PUBLIC when not
    /// set.
    dns_resolution: ?ResourceConfigDnsResolution = null,

    /// IP address or DNS name of the target resource.
    host_address: []const u8,

    /// IP address type of the service-managed Resource Gateway.
    ip_address_type: ?IpAddressType = null,

    /// Number of IPv4 addresses in each ENI for the service-managed Resource
    /// Gateway.
    ipv_4_addresses_per_eni: ?i32 = null,

    /// TCP port ranges that a consumer can use to access the resource.
    port_ranges: ?[]const []const u8 = null,

    /// Security groups to attach to the service-managed Resource Gateway. If not
    /// specified, a default security group is created.
    security_group_ids: ?[]const []const u8 = null,

    /// Subnets that the service-managed Resource Gateway will span.
    subnet_ids: []const []const u8,

    /// VPC to create the service-managed Resource Gateway in.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .certificate = "certificate",
        .dns_resolution = "dnsResolution",
        .host_address = "hostAddress",
        .ip_address_type = "ipAddressType",
        .ipv_4_addresses_per_eni = "ipv4AddressesPerEni",
        .port_ranges = "portRanges",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};
