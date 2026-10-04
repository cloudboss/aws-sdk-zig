/// File content structure for compliance inquiry uploads.
pub const InquiryFileContent = struct {
    /// Binary content of the uploaded file.
    content: []const u8,

    /// List of file sections/sheets to process.
    file_sections: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .content = "content",
        .file_sections = "fileSections",
    };
};
