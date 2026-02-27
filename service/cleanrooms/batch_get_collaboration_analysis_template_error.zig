/// Details of errors thrown by the call to retrieve multiple analysis templates
/// within a collaboration by their identifiers.
pub const BatchGetCollaborationAnalysisTemplateError = struct {
    /// The Amazon Resource Name (ARN) of the analysis template.
    arn: []const u8,

    /// An error code for the error.
    code: []const u8,

    /// A description of why the call failed.
    message: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .code = "code",
        .message = "message",
    };
};
