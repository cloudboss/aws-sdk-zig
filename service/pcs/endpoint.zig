const EndpointType = @import("endpoint_type.zig").EndpointType;

/// An endpoint available for interaction with the scheduler.
pub const Endpoint = struct {
    /// The endpoint's IPv6 address.
    ///
    /// Example: `2001:db8::1`
    ipv_6_address: ?[]const u8,

    /// The endpoint's connection port number.
    ///
    /// Example: `1234`
    port: []const u8,

    /// For clusters that use IPv4, this is the endpoint's private IP address.
    ///
    /// Example: `10.1.2.3`
    ///
    /// For clusters configured to use IPv6, this is an empty string.
    private_ip_address: []const u8,

    /// The endpoint's public IP address.
    ///
    /// Example: `192.0.2.1`
    public_ip_address: ?[]const u8,

    /// Indicates the type of endpoint running at the specific IP address.
    type: EndpointType,

    pub const json_field_names = .{
        .ipv_6_address = "ipv6Address",
        .port = "port",
        .private_ip_address = "privateIpAddress",
        .public_ip_address = "publicIpAddress",
        .type = "type",
    };
};
