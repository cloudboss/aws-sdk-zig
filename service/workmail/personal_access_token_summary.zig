/// The summary of the Personal Access Token.
pub const PersonalAccessTokenSummary = struct {
    /// The date when the Personal Access Token was created.
    date_created: ?i64 = null,

    /// The date when the Personal Access Token was last used.
    date_last_used: ?i64 = null,

    /// The date when the Personal Access Token will expire.
    expires_time: ?i64 = null,

    /// The name of the Personal Access Token.
    name: ?[]const u8 = null,

    /// The ID of the Personal Access Token.
    personal_access_token_id: ?[]const u8 = null,

    /// Lists all the Personal Access Token permissions for a mailbox.
    scopes: ?[]const []const u8 = null,

    /// The user ID of the WorkMail user associated with the Personal Access Token.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .date_created = "DateCreated",
        .date_last_used = "DateLastUsed",
        .expires_time = "ExpiresTime",
        .name = "Name",
        .personal_access_token_id = "PersonalAccessTokenId",
        .scopes = "Scopes",
        .user_id = "UserId",
    };
};
