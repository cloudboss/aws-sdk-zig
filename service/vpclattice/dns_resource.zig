const ResourceConfigurationIpAddressType = @import("resource_configuration_ip_address_type.zig").ResourceConfigurationIpAddressType;

/// The DNS name of the resource.
pub const DnsResource = struct {
    /// The domain name of the resource.
    domain_name: ?[]const u8 = null,

    /// The type of IP address. Dualstack is currently not supported.
    ip_address_type: ?ResourceConfigurationIpAddressType = null,

    pub const json_field_names = .{
        .domain_name = "domainName",
        .ip_address_type = "ipAddressType",
    };
};
