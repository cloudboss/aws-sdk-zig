/// Information about the socket address.
pub const SocketAddress = struct {
    /// Name of a socket address.
    name: []const u8,

    /// Port of a socket address.
    port: i32,

    pub const json_field_names = .{
        .name = "name",
        .port = "port",
    };
};
