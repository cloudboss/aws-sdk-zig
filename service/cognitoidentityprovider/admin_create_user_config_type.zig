const MessageTemplateType = @import("message_template_type.zig").MessageTemplateType;

/// The settings for administrator creation of users in a user pool. Contains
/// settings for
/// allowing user sign-up, customizing invitation messages to new users, and the
/// amount of
/// time before temporary passwords expire.
pub const AdminCreateUserConfigType = struct {
    /// The setting for allowing self-service sign-up. When `true`, only
    /// administrators can create new user profiles. When `false`, users can
    /// register
    /// themselves and create a new user profile with the `SignUp` operation.
    allow_admin_create_user_only: bool = false,

    /// The template for the welcome message to new users. This template must
    /// include the
    /// `{####}` temporary password placeholder if you are creating users with
    /// passwords. If your users don't have passwords, you can omit the placeholder.
    ///
    /// See also [Customizing User Invitation
    /// Messages](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-message-customizations.html#cognito-user-pool-settings-user-invitation-message-customization).
    invite_message_template: ?MessageTemplateType,

    /// This parameter is no longer in use.
    ///
    /// The password expiration limit in days for administrator-created users. When
    /// this time
    /// expires, the user can't sign in with their temporary password. To reset the
    /// account
    /// after that time limit, you must call `AdminCreateUser` again, specifying
    /// `RESEND` for the `MessageAction` parameter.
    ///
    /// The default value for this parameter is 7.
    unused_account_validity_days: i32 = 0,

    pub const json_field_names = .{
        .allow_admin_create_user_only = "AllowAdminCreateUserOnly",
        .invite_message_template = "InviteMessageTemplate",
        .unused_account_validity_days = "UnusedAccountValidityDays",
    };
};
