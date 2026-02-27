/// The configuration for a
/// [SendMessage](https://docs.aws.amazon.com/connect/latest/APIReference/API_amazon-q-connect_SendMessage.html) request.
pub const MessageConfiguration = struct {
    /// Configuration for generating chunked messages.
    generate_chunked_message: ?bool,

    /// Generates a filler response when tool selection is `QUESTION`.
    generate_filler_message: ?bool,

    pub const json_field_names = .{
        .generate_chunked_message = "generateChunkedMessage",
        .generate_filler_message = "generateFillerMessage",
    };
};
