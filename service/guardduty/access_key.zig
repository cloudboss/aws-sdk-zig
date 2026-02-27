/// Contains information about the access keys.
pub const AccessKey = struct {
    /// Principal ID of the user.
    principal_id: ?[]const u8,

    /// Name of the user.
    user_name: ?[]const u8,

    /// Type of the user.
    user_type: ?[]const u8,

    pub const json_field_names = .{
        .principal_id = "PrincipalId",
        .user_name = "UserName",
        .user_type = "UserType",
    };
};
