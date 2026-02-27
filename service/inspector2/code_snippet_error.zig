const CodeSnippetErrorCode = @import("code_snippet_error_code.zig").CodeSnippetErrorCode;

/// Contains information about any errors encountered while trying to retrieve a
/// code
/// snippet.
pub const CodeSnippetError = struct {
    /// The error code for the error that prevented a code snippet from being
    /// retrieved.
    error_code: CodeSnippetErrorCode,

    /// The error message received when Amazon Inspector failed to retrieve a code
    /// snippet.
    error_message: []const u8,

    /// The ARN of the finding that a code snippet couldn't be retrieved for.
    finding_arn: []const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .finding_arn = "findingArn",
    };
};
