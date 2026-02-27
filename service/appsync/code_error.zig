const CodeErrorLocation = @import("code_error_location.zig").CodeErrorLocation;

/// Describes an AppSync error.
pub const CodeError = struct {
    /// The type of code error.
    ///
    /// Examples include, but aren't limited to: `LINT_ERROR`,
    /// `PARSER_ERROR`.
    error_type: ?[]const u8,

    /// The line, column, and span location of the error in the code.
    location: ?CodeErrorLocation,

    /// A user presentable error.
    ///
    /// Examples include, but aren't limited to: `Parsing error: Unterminated string
    /// literal`.
    value: ?[]const u8,

    pub const json_field_names = .{
        .error_type = "errorType",
        .location = "location",
        .value = "value",
    };
};
