pub const ChannelMessagePersistenceType = enum {
    persistent,
    non_persistent,

    pub const json_field_names = .{
        .persistent = "PERSISTENT",
        .non_persistent = "NON_PERSISTENT",
    };
};
