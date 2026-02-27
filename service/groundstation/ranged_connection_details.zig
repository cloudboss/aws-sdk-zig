const RangedSocketAddress = @import("ranged_socket_address.zig").RangedSocketAddress;

/// Ingress address of AgentEndpoint with a port range and an optional mtu.
pub const RangedConnectionDetails = struct {
    /// Maximum transmission unit (MTU) size in bytes of a dataflow endpoint.
    mtu: ?i32,

    /// A ranged socket address.
    socket_address: RangedSocketAddress,

    pub const json_field_names = .{
        .mtu = "mtu",
        .socket_address = "socketAddress",
    };
};
