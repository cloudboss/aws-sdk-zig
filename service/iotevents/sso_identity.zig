/// Contains information about your identity source in AWS Single Sign-On. For
/// more information, see
/// the [AWS Single Sign-On
/// User
/// Guide](https://docs.aws.amazon.com/singlesignon/latest/userguide/what-is.html).
pub const SSOIdentity = struct {
    /// The ID of the AWS SSO identity store.
    identity_store_id: []const u8,

    /// The user ID.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .identity_store_id = "identityStoreId",
        .user_id = "userId",
    };
};
