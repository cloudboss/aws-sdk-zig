/// The streaming configuration, such as the Amazon SNS streaming endpoint.
pub const ChatStreamingConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the standard Amazon SNS topic. The Amazon
    /// Resource Name (ARN) of the streaming endpoint that is used to publish
    /// real-time message streaming for chat conversations.
    streaming_endpoint_arn: []const u8,

    pub const json_field_names = .{
        .streaming_endpoint_arn = "StreamingEndpointArn",
    };
};
