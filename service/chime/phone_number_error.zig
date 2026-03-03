const ErrorCode = @import("error_code.zig").ErrorCode;

/// If the phone number action fails for one or more of the phone numbers in the
/// request, a list of
/// the phone numbers is returned, along with error codes and error messages.
pub const PhoneNumberError = struct {
    /// The error code.
    error_code: ?ErrorCode = null,

    /// The error message.
    error_message: ?[]const u8 = null,

    /// The phone number ID for which the action failed.
    phone_number_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .phone_number_id = "PhoneNumberId",
    };
};
