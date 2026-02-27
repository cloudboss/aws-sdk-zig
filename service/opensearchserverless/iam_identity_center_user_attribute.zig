pub const IamIdentityCenterUserAttribute = enum {
    /// User ID
    user_id,
    /// User Name
    user_name,
    /// Email
    email,

    pub const json_field_names = .{
        .user_id = "UserId",
        .user_name = "UserName",
        .email = "Email",
    };
};
