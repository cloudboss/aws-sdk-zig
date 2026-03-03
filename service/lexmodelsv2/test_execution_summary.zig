const TestExecutionApiMode = @import("test_execution_api_mode.zig").TestExecutionApiMode;
const TestExecutionTarget = @import("test_execution_target.zig").TestExecutionTarget;
const TestExecutionModality = @import("test_execution_modality.zig").TestExecutionModality;
const TestExecutionStatus = @import("test_execution_status.zig").TestExecutionStatus;

/// Summarizes metadata about the test execution.
pub const TestExecutionSummary = struct {
    /// Specifies whether the API mode for the test execution is streaming
    /// or non-streaming.
    api_mode: ?TestExecutionApiMode = null,

    /// The date and time at which the test execution was created.
    creation_date_time: ?i64 = null,

    /// The date and time at which the test execution was last updated.
    last_updated_date_time: ?i64 = null,

    /// Contains information about the bot used for the test execution..
    target: ?TestExecutionTarget = null,

    /// The unique identifier of the test execution.
    test_execution_id: ?[]const u8 = null,

    /// Specifies whether the data used for the test execution is written
    /// or spoken.
    test_execution_modality: ?TestExecutionModality = null,

    /// The current status of the test execution.
    test_execution_status: ?TestExecutionStatus = null,

    /// The unique identifier of the test set used in the test execution.
    test_set_id: ?[]const u8 = null,

    /// The name of the test set used in the test execution.
    test_set_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_mode = "apiMode",
        .creation_date_time = "creationDateTime",
        .last_updated_date_time = "lastUpdatedDateTime",
        .target = "target",
        .test_execution_id = "testExecutionId",
        .test_execution_modality = "testExecutionModality",
        .test_execution_status = "testExecutionStatus",
        .test_set_id = "testSetId",
        .test_set_name = "testSetName",
    };
};
