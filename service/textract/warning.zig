/// A warning about an issue that occurred during asynchronous text analysis
/// (StartDocumentAnalysis) or asynchronous document text detection
/// (StartDocumentTextDetection).
pub const Warning = struct {
    /// The error code for the warning.
    error_code: ?[]const u8,

    /// A list of the pages that the warning applies to.
    pages: ?[]const i32,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .pages = "Pages",
    };
};
