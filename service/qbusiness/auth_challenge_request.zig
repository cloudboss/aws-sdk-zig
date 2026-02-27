/// A request made by Amazon Q Business to a third paty authentication server to
/// authenticate a custom plugin user.
pub const AuthChallengeRequest = struct {
    /// The URL sent by Amazon Q Business to the third party authentication server
    /// to authenticate a custom plugin user through an OAuth protocol.
    authorization_url: []const u8,

    pub const json_field_names = .{
        .authorization_url = "authorizationUrl",
    };
};
