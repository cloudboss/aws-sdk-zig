/// The OAuth2.0 token or user ID that was used to generate the workload access
/// token used for initiating the user authorization flow to retrieve OAuth2.0
/// tokens.
pub const UserIdentifier = union(enum) {
    /// The ID of the user for whom you have retrieved a workload access token for
    user_id: ?[]const u8,
    /// The OAuth2.0 token issued by the user’s identity provider
    user_token: ?[]const u8,

    pub const json_field_names = .{
        .user_id = "userId",
        .user_token = "userToken",
    };
};
