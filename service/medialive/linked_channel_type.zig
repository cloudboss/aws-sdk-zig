/// The values for the role for a linked channel.
pub const LinkedChannelType = enum {
    following_channel,
    primary_channel,

    pub const json_field_names = .{
        .following_channel = "FOLLOWING_CHANNEL",
        .primary_channel = "PRIMARY_CHANNEL",
    };
};
