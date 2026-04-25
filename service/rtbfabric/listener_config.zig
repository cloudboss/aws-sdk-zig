const Protocol = @import("protocol.zig").Protocol;

/// Listener configuration for the protocols (HTTP, HTTPS, or both) accepted by
/// the gateway.
pub const ListenerConfig = struct {
    /// The protocol for connections from clients to the gateway
    protocols: []const Protocol,

    pub const json_field_names = .{
        .protocols = "protocols",
    };
};
