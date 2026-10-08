const AgentCoreRuntimeServerProtocol = @import("agent_core_runtime_server_protocol.zig").AgentCoreRuntimeServerProtocol;

/// The protocol configuration of an AgentCore Runtime resource that a registry
/// record was auto-detected from.
pub const AgentCoreRuntimeProtocolConfiguration = struct {
    /// The server protocol used by the AgentCore Runtime, such as `MCP`, `HTTP`,
    /// `A2A`, or `AGUI`.
    server_protocol: ?AgentCoreRuntimeServerProtocol = null,

    pub const json_field_names = .{
        .server_protocol = "serverProtocol",
    };
};
