const FlushStreamConfiguration = @import("flush_stream_configuration.zig").FlushStreamConfiguration;
const TextType = @import("text_type.zig").TextType;

/// Contains text content to be synthesized into speech.
pub const TextEvent = struct {
    /// Configuration for controlling when synthesized audio flushes to the output
    /// stream.
    flush_stream_configuration: ?FlushStreamConfiguration = null,

    /// The text content to synthesize. If you specify `ssml` as the
    /// `TextType`, follow the SSML format for the input text.
    text: []const u8,

    /// Specifies whether the input text is plain text or SSML. Default: plain text.
    text_type: ?TextType = null,

    pub const json_field_names = .{
        .flush_stream_configuration = "FlushStreamConfiguration",
        .text = "Text",
        .text_type = "TextType",
    };
};
