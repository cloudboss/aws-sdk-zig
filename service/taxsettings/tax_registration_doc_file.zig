/// The tax registration document.
pub const TaxRegistrationDocFile = struct {
    /// The tax registration document content.
    file_content: []const u8,

    /// The tax registration document name.
    file_name: []const u8,

    pub const json_field_names = .{
        .file_content = "fileContent",
        .file_name = "fileName",
    };
};
