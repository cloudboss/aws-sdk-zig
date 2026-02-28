const DocumentType = @import("document_type.zig").DocumentType;

/// Document type for each page in the document.
pub const DocumentTypeListItem = struct {
    /// Page number.
    page: ?i32,

    /// Document type.
    type: ?DocumentType,

    pub const json_field_names = .{
        .page = "Page",
        .type = "Type",
    };
};
