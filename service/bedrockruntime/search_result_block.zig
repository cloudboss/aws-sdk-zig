const CitationsConfig = @import("citations_config.zig").CitationsConfig;
const SearchResultContentBlock = @import("search_result_content_block.zig").SearchResultContentBlock;

/// A search result block that enables natural citations with proper source
/// attribution for retrieved content.
///
/// This field is only supported by Anthropic Claude Opus 4.1, Opus 4, Sonnet
/// 4.5, Sonnet 4, Sonnet 3.7, and 3.5 Haiku models.
pub const SearchResultBlock = struct {
    /// Configuration setting for citations
    citations: ?CitationsConfig = null,

    /// An array of search result content block.
    content: []const SearchResultContentBlock,

    /// The source URL or identifier for the content.
    source: []const u8,

    /// A descriptive title for the search result.
    title: []const u8,

    pub const json_field_names = .{
        .citations = "citations",
        .content = "content",
        .source = "source",
        .title = "title",
    };
};
