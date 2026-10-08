const AccountTargeting = @import("account_targeting.zig").AccountTargeting;
const TestRunStatus = @import("test_run_status.zig").TestRunStatus;

/// Contains summary information about a test run.
pub const TestRunSummary = struct {
    /// Indicates whether the test run targets resources in a single AWS account or
    /// across multiple accounts.
    account_targeting: ?AccountTargeting = null,

    /// The timestamp when the test run ended.
    ended_at: ?i64 = null,

    /// A human-readable reason for test run failure. Only present when the status
    /// is FAILED or ERROR.
    error_message: ?[]const u8 = null,

    /// The ARN of the service the test run belongs to.
    service_arn: ?[]const u8 = null,

    /// The timestamp when the test run started.
    started_at: i64,

    /// The current status of the test run.
    status: TestRunStatus,

    /// The unique identifier of the test run.
    test_run_id: []const u8,

    /// The ARN of the test template the test run was based on.
    test_template_arn: []const u8,

    pub const json_field_names = .{
        .account_targeting = "accountTargeting",
        .ended_at = "endedAt",
        .error_message = "errorMessage",
        .service_arn = "serviceArn",
        .started_at = "startedAt",
        .status = "status",
        .test_run_id = "testRunId",
        .test_template_arn = "testTemplateArn",
    };
};
