/// An IP address/port combination.
pub const SocketAddress = struct {
    /// The IP address for the socket address.
    ip_address: ?[]const u8,

    /// The port for the socket address.
    port: ?i32,

    pub const json_field_names = .{
        .ip_address = "IpAddress",
        .port = "Port",
    };
};
