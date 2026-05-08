const SupplementalDocumentType = @import("supplemental_document_type.zig").SupplementalDocumentType;

/// Supplemental document associated with the invoice.
pub const SupplementalDocument = struct {
    /// The ID of the supplemental document.
    document_id: ?[]const u8 = null,

    /// The type of supplemental document.
    document_type: ?SupplementalDocumentType = null,

    /// The pre-signed URL to download invoice supplemental document.
    document_url: ?[]const u8 = null,

    /// The pre-signed URL expiration date of invoice supplemental document.
    document_url_expiration_date: ?i64 = null,

    pub const json_field_names = .{
        .document_id = "DocumentId",
        .document_type = "DocumentType",
        .document_url = "DocumentUrl",
        .document_url_expiration_date = "DocumentUrlExpirationDate",
    };
};
