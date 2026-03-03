const DocumentType = @import("document_type.zig").DocumentType;

/// Document type for each page in the document.
pub const DocumentTypeListItem = struct {
    /// Page number.
    page: ?i32 = null,

    /// Document type.
    @"type": ?DocumentType = null,

    pub const json_field_names = .{
        .page = "Page",
        .@"type" = "Type",
    };
};
