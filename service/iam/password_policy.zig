/// Contains information about the account password policy.
///
/// This data type is used as a response element in the
/// [GetAccountPasswordPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetAccountPasswordPolicy.html) operation.
pub const PasswordPolicy = struct {
    /// Specifies whether IAM users are allowed to change their own password. Gives
    /// IAM
    /// users permissions to `iam:ChangePassword` for only their user and to the
    /// `iam:GetAccountPasswordPolicy` action. This option does not attach a
    /// permissions policy to each user, rather the permissions are applied at the
    /// account-level
    /// for all users by IAM.
    allow_users_to_change_password: bool = false,

    /// Indicates whether passwords in the account expire. Returns true if
    /// `MaxPasswordAge` contains a value greater than 0. Returns false if
    /// MaxPasswordAge is 0 or not present.
    expire_passwords: bool = false,

    /// Specifies whether IAM users are prevented from setting a new password via
    /// the
    /// Amazon Web Services Management Console after their password has expired. The
    /// IAM user cannot access the console until
    /// an administrator resets the password. IAM users with `iam:ChangePassword`
    /// permission and active access keys can reset their own expired console
    /// password using the
    /// CLI or API.
    hard_expiry: ?bool,

    /// The number of days that an IAM user password is valid.
    max_password_age: ?i32,

    /// Minimum length to require for IAM user passwords.
    minimum_password_length: ?i32,

    /// Specifies the number of previous passwords that IAM users are prevented from
    /// reusing.
    password_reuse_prevention: ?i32,

    /// Specifies whether IAM user passwords must contain at least one lowercase
    /// character (a
    /// to z).
    require_lowercase_characters: bool = false,

    /// Specifies whether IAM user passwords must contain at least one numeric
    /// character (0 to
    /// 9).
    require_numbers: bool = false,

    /// Specifies whether IAM user passwords must contain at least one of the
    /// following
    /// symbols:
    ///
    /// ! @ # $ % ^ & * ( ) _ + - = [ ] { } | '
    require_symbols: bool = false,

    /// Specifies whether IAM user passwords must contain at least one uppercase
    /// character (A
    /// to Z).
    require_uppercase_characters: bool = false,
};
