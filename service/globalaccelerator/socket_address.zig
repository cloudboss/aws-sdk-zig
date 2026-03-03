/// An IP address/port combination.
pub const SocketAddress = struct {
    /// The IP address for the socket address.
    ip_address: ?[]const u8 = null,

    /// The port for the socket address.
    port: ?i32 = null,

    pub const json_field_names = .{
        .ip_address = "IpAddress",
        .port = "Port",
    };
};
