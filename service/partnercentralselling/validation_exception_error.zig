const ValidationExceptionErrorCode = @import("validation_exception_error_code.zig").ValidationExceptionErrorCode;

/// Indicates an invalid value for a field.
///
/// * *REQUIRED_FIELD_MISSING:* The request is missing a required field.
///
/// Fix: Verify your request payload includes all required fields.
/// * *INVALID_ENUM_VALUE:* The enum field value isn't an accepted values.
///
/// Fix: Check the documentation for the list of valid enum values, and update
/// your request with a valid value.
/// * *INVALID_STRING_FORMAT:* The string format is invalid.
///
/// Fix: Confirm that the string is in the expected format (For example: email
/// address, date).
/// * *INVALID_VALUE:* The value isn't valid.
///
/// Fix: Confirm that the value meets the expected criteria and is within the
/// allowable range or set.
/// * *TOO_MANY_VALUES:* There are too many values in a field that expects fewer
///   entries.
///
/// Fix: Reduce the number of values to match the expected limit.
/// * *NOT_ENOUGH_VALUES:* There are not enough values in a field that expects
///   more entries.
///
/// Fix: Increase the number of values to match the expected threshold.
/// * *ACTION_NOT_PERMITTED:* The action isn't permitted due to current state or
///   permissions.
///
/// Fix: Verify that the action is appropriate for the current state, and that
/// you have the necessary permissions to perform it.
/// * *DUPLICATE_KEY_VALUE:* The value in a field duplicates a value that must
///   be unique.
///
/// Fix: Verify that the value is unique and doesn't duplicate an existing value
/// in the system.
pub const ValidationExceptionError = struct {
    /// Specifies the error code for the invalid field value.
    code: ValidationExceptionErrorCode,

    /// Specifies the field name with the invalid value.
    field_name: ?[]const u8 = null,

    /// Specifies the detailed error message for the invalid field value.
    message: []const u8,

    pub const json_field_names = .{
        .code = "Code",
        .field_name = "FieldName",
        .message = "Message",
    };
};
