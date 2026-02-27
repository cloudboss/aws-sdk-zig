/// An object that defines a message that contains text formatted using Amazon
/// Pinpoint Voice Instructions markup.
pub const CallInstructionsMessageType = struct {
    /// The language to use when delivering the message. For a complete list of
    /// supported languages, see the Amazon Polly Developer Guide.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "Text",
    };
};
