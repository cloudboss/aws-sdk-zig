const aws = @import("aws");

const TestCaseExecutionStatus = @import("test_case_execution_status.zig").TestCaseExecutionStatus;

/// Contains information about a test case execution.
pub const TestCaseExecution = struct {
    /// The timestamp when the test case execution ended.
    end_time: ?i64 = null,

    /// The timestamp when the test case execution started.
    start_time: ?i64 = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The identifier of the test case execution.
    test_case_execution_id: ?[]const u8 = null,

    /// The status of the test case execution.
    test_case_execution_status: ?TestCaseExecutionStatus = null,

    /// The identifier of the test case.
    test_case_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
        .tags = "Tags",
        .test_case_execution_id = "TestCaseExecutionId",
        .test_case_execution_status = "TestCaseExecutionStatus",
        .test_case_id = "TestCaseId",
    };
};
