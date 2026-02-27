pub const DetailType = enum {
    basic,
    full,

    pub const json_field_names = .{
        .basic = "BASIC",
        .full = "FULL",
    };
};
