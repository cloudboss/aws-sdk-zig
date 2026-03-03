/// The connector metadata specific to Google Analytics.
pub const GoogleAnalyticsMetadata = struct {
    /// The desired authorization scope for the Google Analytics account.
    o_auth_scopes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .o_auth_scopes = "oAuthScopes",
    };
};
