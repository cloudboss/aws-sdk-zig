const QuickResponseContentProvider = @import("quick_response_content_provider.zig").QuickResponseContentProvider;

/// The content of the quick response stored in different media types.
pub const QuickResponseContents = struct {
    markdown: ?QuickResponseContentProvider = null,

    plain_text: ?QuickResponseContentProvider = null,

    pub const json_field_names = .{
        .markdown = "markdown",
        .plain_text = "plainText",
    };
};
