pub const ResiliencyScoreType = enum {
    compliance,
    @"test",
    alarm,
    sop,

    pub const json_field_names = .{
        .compliance = "COMPLIANCE",
        .@"test" = "TEST",
        .alarm = "ALARM",
        .sop = "SOP",
    };
};
