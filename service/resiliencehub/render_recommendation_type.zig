pub const RenderRecommendationType = enum {
    alarm,
    sop,
    @"test",

    pub const json_field_names = .{
        .alarm = "ALARM",
        .sop = "SOP",
        .@"test" = "TEST",
    };
};
