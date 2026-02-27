pub const TestCaseScenarioType = enum {
    advanced,
    basic,

    pub const json_field_names = .{
        .advanced = "Advanced",
        .basic = "Basic",
    };
};
