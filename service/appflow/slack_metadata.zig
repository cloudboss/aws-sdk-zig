/// The connector metadata specific to Slack.
pub const SlackMetadata = struct {
    /// The desired authorization scope for the Slack account.
    o_auth_scopes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .o_auth_scopes = "oAuthScopes",
    };
};
