/// Supplemental document associated with the invoice.
pub const SupplementalDocument = struct {
    /// The pre-signed URL to download invoice supplemental document.
    document_url: ?[]const u8,

    /// The pre-signed URL expiration date of invoice supplemental document.
    document_url_expiration_date: ?i64,

    pub const json_field_names = .{
        .document_url = "DocumentUrl",
        .document_url_expiration_date = "DocumentUrlExpirationDate",
    };
};
