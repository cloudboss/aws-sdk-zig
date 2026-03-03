const SocketAddress = @import("socket_address.zig").SocketAddress;

/// Egress address of AgentEndpoint with an optional mtu.
pub const ConnectionDetails = struct {
    /// Maximum transmission unit (MTU) size in bytes of a dataflow endpoint.
    mtu: ?i32 = null,

    /// A socket address.
    socket_address: SocketAddress,

    pub const json_field_names = .{
        .mtu = "mtu",
        .socket_address = "socketAddress",
    };
};
