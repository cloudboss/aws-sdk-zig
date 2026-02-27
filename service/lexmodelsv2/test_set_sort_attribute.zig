pub const TestSetSortAttribute = enum {
    test_set_name,
    last_updated_date_time,

    pub const json_field_names = .{
        .test_set_name = "TestSetName",
        .last_updated_date_time = "LastUpdatedDateTime",
    };
};
