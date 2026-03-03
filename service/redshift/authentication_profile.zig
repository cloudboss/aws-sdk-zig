/// Describes an authentication profile.
pub const AuthenticationProfile = struct {
    /// The content of the authentication profile in JSON format.
    /// The maximum length of the JSON string is determined by a quota for your
    /// account.
    authentication_profile_content: ?[]const u8 = null,

    /// The name of the authentication profile.
    authentication_profile_name: ?[]const u8 = null,
};
