const IpPreference = @import("ip_preference.zig").IpPreference;
const DnsResponseType = @import("dns_response_type.zig").DnsResponseType;

/// An object that represents the DNS service discovery information for your
/// virtual
/// node.
pub const DnsServiceDiscovery = struct {
    /// Specifies the DNS service discovery hostname for the virtual node.
    hostname: []const u8,

    /// The preferred IP version that this virtual node uses. Setting the IP
    /// preference on the
    /// virtual node only overrides the IP preference set for the mesh on this
    /// specific
    /// node.
    ip_preference: ?IpPreference,

    /// Specifies the DNS response type for the virtual node.
    response_type: ?DnsResponseType,

    pub const json_field_names = .{
        .hostname = "hostname",
        .ip_preference = "ipPreference",
        .response_type = "responseType",
    };
};
