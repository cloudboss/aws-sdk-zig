/// Provides information about the source and type of temporary security
/// credentials that were issued to an entity.
pub const SessionIssuer = struct {
    /// The unique identifier for the Amazon Web Services account that owns the
    /// entity that was used to get the credentials.
    account_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the source account, Identity and Access
    /// Management (IAM) user, or role that was used to get the credentials.
    arn: ?[]const u8,

    /// The unique identifier for the entity that was used to get the credentials.
    principal_id: ?[]const u8,

    /// The source of the temporary security credentials, such as Root, IAMUser, or
    /// Role.
    type: ?[]const u8,

    /// The name or alias of the user or role that issued the session. This value is
    /// null if the credentials were obtained from a root account that doesn't have
    /// an alias.
    user_name: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .arn = "arn",
        .principal_id = "principalId",
        .type = "type",
        .user_name = "userName",
    };
};
