/// The password policy settings for a user pool, including complexity, history,
/// and
/// length requirements.
pub const PasswordPolicyType = struct {
    /// The minimum length of the password in the policy that you have set. This
    /// value can't
    /// be less than 6.
    minimum_length: ?i32 = null,

    /// The number of previous passwords that you want Amazon Cognito to restrict
    /// each user from
    /// reusing. Users can't set a password that matches any of `n` previous
    /// passwords, where `n` is the value of `PasswordHistorySize`.
    password_history_size: ?i32 = null,

    /// The requirement in a password policy that users must include at least one
    /// lowercase
    /// letter in their password.
    require_lowercase: bool = false,

    /// The requirement in a password policy that users must include at least one
    /// number in
    /// their password.
    require_numbers: bool = false,

    /// The requirement in a password policy that users must include at least one
    /// symbol in
    /// their password.
    require_symbols: bool = false,

    /// The requirement in a password policy that users must include at least one
    /// uppercase
    /// letter in their password.
    require_uppercase: bool = false,

    /// The number of days a temporary password is valid in the password policy. If
    /// the user
    /// doesn't sign in during this time, an administrator must reset their
    /// password. Defaults
    /// to `7`. If you submit a value of `0`, Amazon Cognito treats it as a null
    /// value and sets `TemporaryPasswordValidityDays` to its default value.
    ///
    /// When you set `TemporaryPasswordValidityDays` for a user pool, you can
    /// no longer set a value for the legacy `UnusedAccountValidityDays`
    /// parameter in that user pool.
    temporary_password_validity_days: i32 = 0,

    pub const json_field_names = .{
        .minimum_length = "MinimumLength",
        .password_history_size = "PasswordHistorySize",
        .require_lowercase = "RequireLowercase",
        .require_numbers = "RequireNumbers",
        .require_symbols = "RequireSymbols",
        .require_uppercase = "RequireUppercase",
        .temporary_password_validity_days = "TemporaryPasswordValidityDays",
    };
};
