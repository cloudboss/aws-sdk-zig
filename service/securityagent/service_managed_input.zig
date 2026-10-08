const ResourceConfigDnsResolution = @import("resource_config_dns_resolution.zig").ResourceConfigDnsResolution;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;

/// The configuration for a service-managed private connection.
pub const ServiceManagedInput = struct {
    /// The certificate for the private connection.
    certificate: ?[]const u8 = null,

    /// The DNS resolution mode for the resource gateway. Defaults to PUBLIC when
    /// not set.
    dns_resolution: ?ResourceConfigDnsResolution = null,

    /// The IP address or DNS name of the target resource.
    host_address: []const u8,

    /// The IP address type of the service-managed resource gateway.
    ip_address_type: ?IpAddressType = null,

    /// The number of IPv4 addresses in each elastic network interface for the
    /// service-managed resource gateway.
    ipv_4_addresses_per_eni: ?i32 = null,

    /// The TCP port ranges that a consumer can use to access the resource.
    port_ranges: ?[]const []const u8 = null,

    /// The security groups to attach to the service-managed resource gateway.
    security_group_ids: ?[]const []const u8 = null,

    /// The subnets that the service-managed resource gateway spans.
    subnet_ids: []const []const u8,

    /// The VPC to create the service-managed resource gateway in.
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
