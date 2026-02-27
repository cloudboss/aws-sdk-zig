const Status = @import("status.zig").Status;
const TestCaseScenario = @import("test_case_scenario.zig").TestCaseScenario;

/// Provides the test case run.
pub const TestCaseRun = struct {
    /// Provides test case run end time.
    end_time: ?i64,

    /// Provides test case run failure result.
    failure: ?[]const u8,

    /// Provides test case run log URL.
    log_url: ?[]const u8,

    /// Provides test case run start time.
    start_time: ?i64,

    /// Provides the test case run status. Status is one of the following:
    ///
    /// * `PASS`: Test passed.
    ///
    /// * `FAIL`: Test failed.
    ///
    /// * `PENDING`: Test has not started running but is scheduled.
    ///
    /// * `RUNNING`: Test is running.
    ///
    /// * `STOPPING`: Test is performing cleanup steps. You will see this
    /// status only if you stop a suite run.
    ///
    /// * `STOPPED` Test is stopped. You will see this status only if you
    /// stop a suite run.
    ///
    /// * `PASS_WITH_WARNINGS`: Test passed with warnings.
    ///
    /// * `ERORR`: Test faced an error when running due to an internal
    /// issue.
    status: ?Status,

    /// Provides the test case run definition ID.
    test_case_definition_id: ?[]const u8,

    /// Provides the test case run definition name.
    test_case_definition_name: ?[]const u8,

    /// Provides the test case run ID.
    test_case_run_id: ?[]const u8,

    /// Provides the test scenarios for the test case run.
    test_scenarios: ?[]const TestCaseScenario,

    /// Provides test case run warnings.
    warnings: ?[]const u8,

    pub const json_field_names = .{
        .end_time = "endTime",
        .failure = "failure",
        .log_url = "logUrl",
        .start_time = "startTime",
        .status = "status",
        .test_case_definition_id = "testCaseDefinitionId",
        .test_case_definition_name = "testCaseDefinitionName",
        .test_case_run_id = "testCaseRunId",
        .test_scenarios = "testScenarios",
        .warnings = "warnings",
    };
};
