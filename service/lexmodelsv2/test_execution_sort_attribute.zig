pub const TestExecutionSortAttribute = enum {
    test_set_name,
    creation_date_time,

    pub const json_field_names = .{
        .test_set_name = "TestSetName",
        .creation_date_time = "CreationDateTime",
    };
};
