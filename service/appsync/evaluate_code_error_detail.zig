const CodeError = @import("code_error.zig").CodeError;

/// Contains the list of errors from a code evaluation response.
pub const EvaluateCodeErrorDetail = struct {
    /// Contains the list of `CodeError` objects.
    code_errors: ?[]const CodeError = null,

    /// The error payload.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_errors = "codeErrors",
        .message = "message",
    };
};
