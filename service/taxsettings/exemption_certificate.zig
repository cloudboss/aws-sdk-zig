/// The exemption certificate.
pub const ExemptionCertificate = struct {
    /// The exemption certificate file content.
    document_file: []const u8,

    /// The exemption certificate file name.
    document_name: []const u8,

    pub const json_field_names = .{
        .document_file = "documentFile",
        .document_name = "documentName",
    };
};
