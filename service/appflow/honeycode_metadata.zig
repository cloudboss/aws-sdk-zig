/// The connector metadata specific to Amazon Honeycode.
pub const HoneycodeMetadata = struct {
    /// The desired authorization scope for the Amazon Honeycode account.
    o_auth_scopes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .o_auth_scopes = "oAuthScopes",
    };
};
