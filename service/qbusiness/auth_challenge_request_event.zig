/// An authentication verification event activated by an end user request to use
/// a custom plugin.
pub const AuthChallengeRequestEvent = struct {
    /// The URL sent by Amazon Q Business to a third party authentication server in
    /// response to an authentication verification event activated by an end user
    /// request to use a custom plugin.
    authorization_url: []const u8,

    pub const json_field_names = .{
        .authorization_url = "authorizationUrl",
    };
};
