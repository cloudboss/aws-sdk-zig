pub const ChannelPrivacy = enum {
    public,
    private,

    pub const json_field_names = .{
        .public = "PUBLIC",
        .private = "PRIVATE",
    };
};
