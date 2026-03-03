const WarningCode = @import("warning_code.zig").WarningCode;

/// The warning code and message that explains a problem with a query.
pub const Warning = struct {
    /// The code used to show the type of warning for the query.
    code: ?WarningCode = null,

    /// The message that explains the problem with the query.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
