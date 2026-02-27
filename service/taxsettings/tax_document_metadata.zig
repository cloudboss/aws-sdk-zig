/// The metadata for your tax document.
pub const TaxDocumentMetadata = struct {
    /// The tax document access token, which contains information that the Tax
    /// Settings API uses to locate the tax document.
    ///
    /// If you update your tax registration, the existing `taxDocumentAccessToken`
    /// won't be valid. To get the latest token, call the `GetTaxRegistration` or
    /// `ListTaxRegistrations` API operation. This token is valid for 24 hours.
    tax_document_access_token: []const u8,

    /// The name of your tax document.
    tax_document_name: []const u8,

    pub const json_field_names = .{
        .tax_document_access_token = "taxDocumentAccessToken",
        .tax_document_name = "taxDocumentName",
    };
};
