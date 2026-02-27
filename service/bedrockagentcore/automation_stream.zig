const AutomationStreamStatus = @import("automation_stream_status.zig").AutomationStreamStatus;

/// The configuration for a stream that enables programmatic control of a
/// browser session in Amazon Bedrock AgentCore. This stream provides a
/// bidirectional communication channel for sending commands to the browser and
/// receiving responses, allowing agents to automate web interactions such as
/// navigation, form filling, and element clicking.
pub const AutomationStream = struct {
    /// The endpoint URL for the automation stream. This URL is used to establish a
    /// WebSocket connection to the stream for sending commands and receiving
    /// responses.
    stream_endpoint: []const u8,

    /// The current status of the automation stream. This indicates whether the
    /// stream is available for use. Possible values include ACTIVE, CONNECTING, and
    /// DISCONNECTED.
    stream_status: AutomationStreamStatus,

    pub const json_field_names = .{
        .stream_endpoint = "streamEndpoint",
        .stream_status = "streamStatus",
    };
};
