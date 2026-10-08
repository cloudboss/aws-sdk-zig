/// Details for completing OAuth authorization step.
pub const OAuthAdditionalStepDetails = struct {
    /// The URL to redirect the user to for OAuth authorization.
    authorization_url: []const u8,

    pub const json_field_names = .{
        .authorization_url = "authorizationUrl",
    };
};
