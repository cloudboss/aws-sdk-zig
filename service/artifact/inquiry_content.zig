const InquiryFileContent = @import("inquiry_file_content.zig").InquiryFileContent;

/// Content for creating a compliance inquiry - either a single query or file
/// content.
pub const InquiryContent = union(enum) {
    /// File content with multiple questions.
    file_content: ?InquiryFileContent,
    /// Single text query for AI-generated answer.
    query: ?[]const u8,

    pub const json_field_names = .{
        .file_content = "fileContent",
        .query = "query",
    };
};
