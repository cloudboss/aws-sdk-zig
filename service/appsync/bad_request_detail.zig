const CodeError = @import("code_error.zig").CodeError;

/// Provides further details for the reason behind the bad request. For reason
/// type
/// `CODE_ERROR`, the detail will contain a list of code errors.
pub const BadRequestDetail = struct {
    /// Contains the list of errors in the request.
    code_errors: ?[]const CodeError = null,

    pub const json_field_names = .{
        .code_errors = "codeErrors",
    };
};
