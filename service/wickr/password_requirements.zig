/// Defines password complexity requirements for users in a security group,
/// including minimum length and character type requirements.
pub const PasswordRequirements = struct {
    /// The minimum number of lowercase letters required in passwords.
    lowercase: ?i32,

    /// The minimum password length in characters.
    min_length: ?i32,

    /// The minimum number of numeric characters required in passwords.
    numbers: ?i32,

    /// The minimum number of special symbol characters required in passwords.
    symbols: ?i32,

    /// The minimum number of uppercase letters required in passwords.
    uppercase: ?i32,

    pub const json_field_names = .{
        .lowercase = "lowercase",
        .min_length = "minLength",
        .numbers = "numbers",
        .symbols = "symbols",
        .uppercase = "uppercase",
    };
};
