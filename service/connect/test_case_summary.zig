const TestCaseStatus = @import("test_case_status.zig").TestCaseStatus;

/// Contains summary information about a test case.
pub const TestCaseSummary = struct {
    /// The Amazon Resource Name (ARN) of the test case.
    arn: ?[]const u8,

    /// The identifier of the test case.
    id: ?[]const u8,

    /// The region in which the test case was last modified.
    last_modified_region: ?[]const u8,

    /// The time at which the test case was last modified.
    last_modified_time: ?i64,

    /// The name of the test case.
    name: ?[]const u8,

    /// The status of the test case.
    status: ?TestCaseStatus,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .status = "Status",
    };
};
