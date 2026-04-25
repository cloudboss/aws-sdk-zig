/// Attributes of the session that the key was used for.
pub const AwsIamAccessKeySessionContextAttributes = struct {
    /// Indicates when the session was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    creation_date: ?[]const u8 = null,

    /// Indicates whether the session used multi-factor authentication (MFA).
    mfa_authenticated: ?bool = null,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .mfa_authenticated = "MfaAuthenticated",
    };
};
