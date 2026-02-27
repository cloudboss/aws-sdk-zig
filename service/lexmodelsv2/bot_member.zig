/// A bot that is a member of a network of bots.
pub const BotMember = struct {
    /// The alias ID of a bot that is a member of this network of bots.
    bot_member_alias_id: []const u8,

    /// The alias name of a bot that is a member of this network of bots.
    bot_member_alias_name: []const u8,

    /// The unique ID of a bot that is a member of this network of bots.
    bot_member_id: []const u8,

    /// The unique name of a bot that is a member of this network of bots.
    bot_member_name: []const u8,

    /// The version of a bot that is a member of this network of bots.
    bot_member_version: []const u8,

    pub const json_field_names = .{
        .bot_member_alias_id = "botMemberAliasId",
        .bot_member_alias_name = "botMemberAliasName",
        .bot_member_id = "botMemberId",
        .bot_member_name = "botMemberName",
        .bot_member_version = "botMemberVersion",
    };
};
