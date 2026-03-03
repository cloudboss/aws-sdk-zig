/// The list of errors returned when errors are encountered during the
/// BatchCreateAttendee and CreateAttendee actions. This includes external user
/// IDs, error codes, and error messages.
pub const CreateAttendeeError = struct {
    /// The error code.
    error_code: ?[]const u8 = null,

    /// The error message.
    error_message: ?[]const u8 = null,

    /// The Amazon Chime SDK external user ID. An idempotency token. Links the
    /// attendee to an identity managed by a builder application.
    ///
    /// Pattern: `[-_&@+=,(){}\[\]\/«».:|'"#a-zA-Z0-9À-ÿ\s]*`
    ///
    /// Values that begin with `aws:` are reserved. You can't configure a value that
    /// uses this prefix.
    /// Case insensitive.
    external_user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .external_user_id = "ExternalUserId",
    };
};
