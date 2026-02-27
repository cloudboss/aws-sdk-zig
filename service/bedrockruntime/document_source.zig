const DocumentContentBlock = @import("document_content_block.zig").DocumentContentBlock;
const S3Location = @import("s3_location.zig").S3Location;

/// Contains the content of a document.
pub const DocumentSource = union(enum) {
    /// The raw bytes for the document. If you use an Amazon Web Services SDK, you
    /// don't need to encode the bytes in base64.
    bytes: ?[]const u8,
    /// The structured content of the document source, which may include various
    /// content blocks such as text, images, or other document elements.
    content: ?[]const DocumentContentBlock,
    /// The location of a document object in an Amazon S3 bucket. To see which
    /// models support S3 uploads, see [Supported models and features for
    /// Converse](https://docs.aws.amazon.com/bedrock/latest/userguide/conversation-inference-supported-models-features.html).
    s_3_location: ?S3Location,
    /// The text content of the document source.
    text: ?[]const u8,

    pub const json_field_names = .{
        .bytes = "bytes",
        .content = "content",
        .s_3_location = "s3Location",
        .text = "text",
    };
};
