pub const StatefulRuleDirection = enum {
    forward,
    any,

    pub const json_field_names = .{
        .forward = "FORWARD",
        .any = "ANY",
    };
};
