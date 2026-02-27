/// The connector metadata specific to Zendesk.
pub const ZendeskMetadata = struct {
    /// The desired authorization scope for the Zendesk account.
    o_auth_scopes: ?[]const []const u8,

    pub const json_field_names = .{
        .o_auth_scopes = "oAuthScopes",
    };
};
