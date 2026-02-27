pub const SubjectKeyIdCOption = enum {
    user_name,
    user_id,
    email,

    pub const json_field_names = .{
        .user_name = "UserName",
        .user_id = "UserId",
        .email = "Email",
    };
};
