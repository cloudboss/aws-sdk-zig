/// Contains the user name and password create date for a user.
///
/// This data type is used as a response element in the
/// [CreateLoginProfile](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateLoginProfile.html) and
/// [GetLoginProfile](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetLoginProfile.html) operations.
pub const LoginProfile = struct {
    /// The date when the password for the user was created.
    create_date: i64,

    /// Specifies whether the user is required to set a new password on next
    /// sign-in.
    password_reset_required: bool = false,

    /// The name of the user, which can be used for signing in to the Amazon Web
    /// Services Management Console.
    user_name: []const u8,
};
