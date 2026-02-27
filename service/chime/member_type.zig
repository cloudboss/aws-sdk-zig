pub const MemberType = enum {
    user,
    bot,
    webhook,

    pub const json_field_names = .{
        .user = "User",
        .bot = "Bot",
        .webhook = "Webhook",
    };
};
