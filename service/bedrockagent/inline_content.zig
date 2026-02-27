const ByteContentDoc = @import("byte_content_doc.zig").ByteContentDoc;
const TextContentDoc = @import("text_content_doc.zig").TextContentDoc;
const InlineContentType = @import("inline_content_type.zig").InlineContentType;

/// Contains information about content defined inline to ingest into a data
/// source. Choose a `type` and include the field that corresponds to it.
pub const InlineContent = struct {
    /// Contains information about content defined inline in bytes.
    byte_content: ?ByteContentDoc,

    /// Contains information about content defined inline in text.
    text_content: ?TextContentDoc,

    /// The type of inline content to define.
    type: InlineContentType,

    pub const json_field_names = .{
        .byte_content = "byteContent",
        .text_content = "textContent",
        .type = "type",
    };
};
