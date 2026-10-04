/// The analysis log export error.
pub const AnalysisLogExportError = struct {
    /// The error code for the analysis log export.
    code: []const u8,

    /// The message for the analysis log export error.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
