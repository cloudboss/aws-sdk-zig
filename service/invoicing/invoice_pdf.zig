const SupplementalDocument = @import("supplemental_document.zig").SupplementalDocument;

/// Invoice document data.
pub const InvoicePDF = struct {
    /// The pre-signed URL to download the invoice document.
    document_url: ?[]const u8 = null,

    /// The pre-signed URL expiration date of the invoice document.
    document_url_expiration_date: ?i64 = null,

    /// Your unique invoice ID.
    invoice_id: ?[]const u8 = null,

    /// List of supplemental documents associated with the invoice.
    supplemental_documents: ?[]const SupplementalDocument = null,

    pub const json_field_names = .{
        .document_url = "DocumentUrl",
        .document_url_expiration_date = "DocumentUrlExpirationDate",
        .invoice_id = "InvoiceId",
        .supplemental_documents = "SupplementalDocuments",
    };
};
