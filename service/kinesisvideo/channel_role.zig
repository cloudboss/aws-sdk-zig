pub const ChannelRole = enum {
    master,
    viewer,

    pub const json_field_names = .{
        .master = "MASTER",
        .viewer = "VIEWER",
    };
};
