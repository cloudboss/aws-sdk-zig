/// An entry that appears when a `KeyRegistration` update to Quick Sight fails.
pub const FailedKeyRegistrationEntry = struct {
    /// The ARN of the KMS key that failed to update.
    key_arn: ?[]const u8,

    /// A message that provides information about why a `FailedKeyRegistrationEntry`
    /// error occurred.
    message: []const u8,

    /// A boolean that indicates whether a `FailedKeyRegistrationEntry` resulted
    /// from user error. If the value of this property is `True`, the error was
    /// caused by user error. If the value of this property is `False`, the error
    /// occurred on the backend. If your job continues fail and with a `False`
    /// `SenderFault` value, contact Amazon Web Services Support.
    sender_fault: bool = false,

    /// The HTTP status of a `FailedKeyRegistrationEntry` error.
    status_code: i32 = 0,

    pub const json_field_names = .{
        .key_arn = "KeyArn",
        .message = "Message",
        .sender_fault = "SenderFault",
        .status_code = "StatusCode",
    };
};
