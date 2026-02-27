pub const SlackEntity = enum {
    public_channel,
    private_channel,
    group_message,
    direct_message,

    pub const json_field_names = .{
        .public_channel = "PUBLIC_CHANNEL",
        .private_channel = "PRIVATE_CHANNEL",
        .group_message = "GROUP_MESSAGE",
        .direct_message = "DIRECT_MESSAGE",
    };
};
