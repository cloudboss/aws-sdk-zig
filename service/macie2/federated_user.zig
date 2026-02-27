const SessionContext = @import("session_context.zig").SessionContext;

/// Provides information about an identity that performed an action on an
/// affected resource by using temporary security credentials. The credentials
/// were obtained using the GetFederationToken operation of the Security Token
/// Service (STS) API.
pub const FederatedUser = struct {
    /// The Amazon Web Services access key ID that identifies the credentials.
    access_key_id: ?[]const u8,

    /// The unique identifier for the Amazon Web Services account that owns the
    /// entity that was used to get the credentials.
    account_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the entity that was used to get the
    /// credentials.
    arn: ?[]const u8,

    /// The unique identifier for the entity that was used to get the credentials.
    principal_id: ?[]const u8,

    /// The details of the session that was created for the credentials, including
    /// the entity that issued the session.
    session_context: ?SessionContext,

    pub const json_field_names = .{
        .access_key_id = "accessKeyId",
        .account_id = "accountId",
        .arn = "arn",
        .principal_id = "principalId",
        .session_context = "sessionContext",
    };
};
