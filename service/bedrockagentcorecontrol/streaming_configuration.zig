/// The streaming configuration for an MCP gateway. This structure defines
/// settings that control response streaming behavior.
pub const StreamingConfiguration = struct {
    /// Indicates whether response streaming is enabled for the gateway. When set to
    /// `true`, the gateway streams responses from targets back to the client.
    enable_response_streaming: ?bool = null,

    pub const json_field_names = .{
        .enable_response_streaming = "enableResponseStreaming",
    };
};
