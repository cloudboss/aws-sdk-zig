const DocumentBlock = @import("document_block.zig").DocumentBlock;
const ImageBlock = @import("image_block.zig").ImageBlock;
const SearchResultBlock = @import("search_result_block.zig").SearchResultBlock;
const VideoBlock = @import("video_block.zig").VideoBlock;

/// The tool result content block. For more information, see [Call a tool with
/// the Converse
/// API](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html) in
/// the Amazon Bedrock User Guide.
pub const ToolResultContentBlock = union(enum) {
    /// A tool result that is a document.
    document: ?DocumentBlock,
    /// A tool result that is an image.
    ///
    /// This field is only supported by Amazon Nova and Anthropic Claude 3 and 4
    /// models.
    image: ?ImageBlock,
    /// A tool result that is JSON format data.
    json: ?[]const u8,
    /// A tool result that is a search result.
    search_result: ?SearchResultBlock,
    /// A tool result that is text.
    text: ?[]const u8,
    /// A tool result that is video.
    video: ?VideoBlock,

    pub const json_field_names = .{
        .document = "document",
        .image = "image",
        .json = "json",
        .search_result = "searchResult",
        .text = "text",
        .video = "video",
    };
};
