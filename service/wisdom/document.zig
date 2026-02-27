const ContentReference = @import("content_reference.zig").ContentReference;
const DocumentText = @import("document_text.zig").DocumentText;

/// The document.
pub const Document = struct {
    /// A reference to the content resource.
    content_reference: ContentReference,

    /// The excerpt from the document.
    excerpt: ?DocumentText,

    /// The title of the document.
    title: ?DocumentText,

    pub const json_field_names = .{
        .content_reference = "contentReference",
        .excerpt = "excerpt",
        .title = "title",
    };
};
