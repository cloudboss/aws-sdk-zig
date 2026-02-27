pub const ActionCategory = enum {
    source,
    build,
    deploy,
    @"test",
    invoke,
    approval,
    compute,

    pub const json_field_names = .{
        .source = "Source",
        .build = "Build",
        .deploy = "Deploy",
        .@"test" = "Test",
        .invoke = "Invoke",
        .approval = "Approval",
        .compute = "Compute",
    };
};
