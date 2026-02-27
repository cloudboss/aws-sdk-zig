/// Identifies a Amazon Cognito user group. A user group can be used in on or
/// more work teams.
pub const CognitoMemberDefinition = struct {
    /// An identifier for an application client. You must create the app client ID
    /// using Amazon Cognito.
    client_id: []const u8,

    /// An identifier for a user group.
    user_group: []const u8,

    /// An identifier for a user pool. The user pool must be in the same region as
    /// the service that you are calling.
    user_pool: []const u8,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .user_group = "UserGroup",
        .user_pool = "UserPool",
    };
};
