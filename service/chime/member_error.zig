const ErrorCode = @import("error_code.zig").ErrorCode;

/// The list of errors returned when a member action results in an error.
pub const MemberError = struct {
    /// The error code.
    error_code: ?ErrorCode = null,

    /// The error message.
    error_message: ?[]const u8 = null,

    /// The member ID.
    member_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .member_id = "MemberId",
    };
};
