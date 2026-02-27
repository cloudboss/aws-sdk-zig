/// A list of DNS server name and server IP. This is used to set up Route-53
/// outbound resolvers.
pub const CustomDNSServer = struct {
    /// The IP address of the DNS server.
    custom_dns_server_ip: []const u8,

    /// The name of the DNS server.
    custom_dns_server_name: []const u8,

    pub const json_field_names = .{
        .custom_dns_server_ip = "customDNSServerIP",
        .custom_dns_server_name = "customDNSServerName",
    };
};
