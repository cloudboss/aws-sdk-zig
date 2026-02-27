pub const ChannelMessageType = enum {
    standard,
    control,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .control = "CONTROL",
    };
};
