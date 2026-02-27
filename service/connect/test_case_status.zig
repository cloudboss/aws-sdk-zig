/// The status of a test case.
pub const TestCaseStatus = enum {
    published,
    saved,

    pub const json_field_names = .{
        .published = "PUBLISHED",
        .saved = "SAVED",
    };
};
