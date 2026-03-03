/// The configuration for a stream that provides a visual representation of a
/// browser session in Amazon Bedrock AgentCore. This stream enables agents to
/// observe the current state of the browser, including rendered web pages,
/// visual elements, and the results of interactions.
pub const LiveViewStream = struct {
    /// The endpoint URL for the live view stream. This URL is used to establish a
    /// connection to receive visual updates from the browser session.
    stream_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .stream_endpoint = "streamEndpoint",
    };
};
