const InputImageFormat = @import("input_image_format.zig").InputImageFormat;

/// Contains the image data for multimodal knowledge base queries, including
/// format and content.
///
/// This data type is used in the following API operations:
///
/// * [Retrieve
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_Retrieve.html#API_agent-runtime_Retrieve_RequestSyntax) – in the `image` field
pub const InputImage = struct {
    /// The format of the input image. Supported formats include png, gif, jpeg, and
    /// webp.
    format: InputImageFormat,

    /// The base64-encoded image data for inline image content. Maximum size is 5MB.
    inline_content: []const u8,

    pub const json_field_names = .{
        .format = "format",
        .inline_content = "inlineContent",
    };
};
