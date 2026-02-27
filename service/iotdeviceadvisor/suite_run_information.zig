const SuiteRunStatus = @import("suite_run_status.zig").SuiteRunStatus;

/// Information about the suite run.
///
/// Requires permission to access the
/// [SuiteRunInformation](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
pub const SuiteRunInformation = struct {
    /// Date (in Unix epoch time) when the suite run was created.
    created_at: ?i64,

    /// Date (in Unix epoch time) when the suite run ended.
    end_at: ?i64,

    /// Number of test cases that failed in the suite run.
    failed: ?i32,

    /// Number of test cases that passed in the suite run.
    passed: ?i32,

    /// Date (in Unix epoch time) when the suite run was started.
    started_at: ?i64,

    /// Status of the suite run.
    status: ?SuiteRunStatus,

    /// Suite definition ID of the suite run.
    suite_definition_id: ?[]const u8,

    /// Suite definition name of the suite run.
    suite_definition_name: ?[]const u8,

    /// Suite definition version of the suite run.
    suite_definition_version: ?[]const u8,

    /// Suite run ID of the suite run.
    suite_run_id: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .end_at = "endAt",
        .failed = "failed",
        .passed = "passed",
        .started_at = "startedAt",
        .status = "status",
        .suite_definition_id = "suiteDefinitionId",
        .suite_definition_name = "suiteDefinitionName",
        .suite_definition_version = "suiteDefinitionVersion",
        .suite_run_id = "suiteRunId",
    };
};
