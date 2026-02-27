/// A success entry that occurs when a `KeyRegistration` job is successfully
/// applied to the Quick Sight account.
pub const SuccessfulKeyRegistrationEntry = struct {
    /// The ARN of the KMS key that is associated with the
    /// `SuccessfulKeyRegistrationEntry` entry.
    key_arn: []const u8,

    /// The HTTP status of a `SuccessfulKeyRegistrationEntry` entry.
    status_code: i32 = 0,

    pub const json_field_names = .{
        .key_arn = "KeyArn",
        .status_code = "StatusCode",
    };
};
