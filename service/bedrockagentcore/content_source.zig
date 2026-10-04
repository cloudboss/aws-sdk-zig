const InlineMemoryContent = @import("inline_memory_content.zig").InlineMemoryContent;

/// The source of the content to ingest. Only inline content is supported.
pub const ContentSource = union(enum) {
    /// The content included directly in the request.
    @"inline": ?InlineMemoryContent,

    pub const json_field_names = .{
        .@"inline" = "inline",
    };
};
