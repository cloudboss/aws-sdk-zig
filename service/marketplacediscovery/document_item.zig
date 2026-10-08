const LegalDocumentType = @import("legal_document_type.zig").LegalDocumentType;

/// A legal document associated with a legal term, such as a EULA or data
/// subscription agreement.
pub const DocumentItem = struct {
    /// The category of the legal document, such as `StandardEula` or `CustomEula`.
    type: LegalDocumentType,

    /// The URL where the legal document can be accessed.
    url: []const u8,

    /// The version of the standard contract, if applicable.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .type = "type",
        .url = "url",
        .version = "version",
    };
};
