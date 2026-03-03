/// Contains information about the access keys.
pub const AccessKeyDetails = struct {
    /// The access key ID of the user.
    access_key_id: ?[]const u8 = null,

    /// The principal ID of the user.
    principal_id: ?[]const u8 = null,

    /// The name of the user.
    user_name: ?[]const u8 = null,

    /// The type of the user.
    user_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_key_id = "AccessKeyId",
        .principal_id = "PrincipalId",
        .user_name = "UserName",
        .user_type = "UserType",
    };
};
