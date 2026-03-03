const DocumentText = @import("document_text.zig").DocumentText;

/// Details about the source content text data.
pub const TextData = struct {
    excerpt: ?DocumentText = null,

    title: ?DocumentText = null,

    pub const json_field_names = .{
        .excerpt = "excerpt",
        .title = "title",
    };
};
