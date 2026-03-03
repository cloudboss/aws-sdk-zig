const AttributeType = @import("attribute_type.zig").AttributeType;
const MFAOptionType = @import("mfa_option_type.zig").MFAOptionType;
const UserStatusType = @import("user_status_type.zig").UserStatusType;

/// A user profile in a Amazon Cognito user pool.
pub const UserType = struct {
    /// Names and values of a user's attributes, for example `email`.
    attributes: ?[]const AttributeType = null,

    /// Indicates whether the user's account is enabled or disabled.
    enabled: bool = false,

    /// The user's MFA configuration.
    mfa_options: ?[]const MFAOptionType = null,

    /// The date and time when the item was created. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    user_create_date: ?i64 = null,

    /// The date and time when the item was modified. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    user_last_modified_date: ?i64 = null,

    /// The user's username.
    username: ?[]const u8 = null,

    /// The user status. This can be one of the following:
    ///
    /// * `UNCONFIRMED`: User has been created but not confirmed.
    ///
    /// * `CONFIRMED`: User has been confirmed.
    ///
    /// * `EXTERNAL_PROVIDER`: User signed in with a third-party IdP.
    ///
    /// * `RESET_REQUIRED`: User is confirmed, but the user must request a
    /// code and reset their password before they can sign in.
    ///
    /// * `FORCE_CHANGE_PASSWORD`: The user is confirmed and the user can
    /// sign in using a temporary password, but on first sign-in, the user must
    /// change
    /// their password to a new value before doing anything else.
    ///
    /// The statuses `ARCHIVED`, `UNKNOWN`, and `COMPROMISED`
    /// are no longer used.
    user_status: ?UserStatusType = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .enabled = "Enabled",
        .mfa_options = "MFAOptions",
        .user_create_date = "UserCreateDate",
        .user_last_modified_date = "UserLastModifiedDate",
        .username = "Username",
        .user_status = "UserStatus",
    };
};
