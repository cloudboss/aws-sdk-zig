const TestCaseScenarioStatus = @import("test_case_scenario_status.zig").TestCaseScenarioStatus;
const TestCaseScenarioType = @import("test_case_scenario_type.zig").TestCaseScenarioType;

/// Provides test case scenario.
pub const TestCaseScenario = struct {
    /// Provides test case scenario failure result.
    failure: ?[]const u8 = null,

    /// Provides the test case scenario status. Status is one of the following:
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
    status: ?TestCaseScenarioStatus = null,

    /// Provides test case scenario system messages if any.
    system_message: ?[]const u8 = null,

    /// Provides test case scenario ID.
    test_case_scenario_id: ?[]const u8 = null,

    /// Provides test case scenario type. Type is one of the following:
    ///
    /// * Advanced
    ///
    /// * Basic
    test_case_scenario_type: ?TestCaseScenarioType = null,

    pub const json_field_names = .{
        .failure = "failure",
        .status = "status",
        .system_message = "systemMessage",
        .test_case_scenario_id = "testCaseScenarioId",
        .test_case_scenario_type = "testCaseScenarioType",
    };
};
