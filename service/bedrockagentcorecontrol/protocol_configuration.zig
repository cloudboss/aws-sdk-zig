const ServerProtocol = @import("server_protocol.zig").ServerProtocol;

/// The protocol configuration for an agent runtime. This structure defines how
/// the agent runtime communicates with clients.
pub const ProtocolConfiguration = struct {
    /// The server protocol for the agent runtime. This field specifies which
    /// protocol the agent runtime uses to communicate with clients.
    server_protocol: ServerProtocol,

    pub const json_field_names = .{
        .server_protocol = "serverProtocol",
    };
};
