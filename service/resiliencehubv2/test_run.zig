const aws = @import("aws");

const AccountTargeting = @import("account_targeting.zig").AccountTargeting;
const ExperimentDetails = @import("experiment_details.zig").ExperimentDetails;
const LoggingConfiguration = @import("logging_configuration.zig").LoggingConfiguration;
const PermissionModel = @import("permission_model.zig").PermissionModel;
const TestRunPolicySnapshot = @import("test_run_policy_snapshot.zig").TestRunPolicySnapshot;
const TestRunReportConfiguration = @import("test_run_report_configuration.zig").TestRunReportConfiguration;
const ReportGenerationResult = @import("report_generation_result.zig").ReportGenerationResult;
const TestRunStatus = @import("test_run_status.zig").TestRunStatus;
const StopCondition = @import("stop_condition.zig").StopCondition;

/// Represents a single run of a test. Configuration is snapshotted from the
/// test and service at the time the run is started.
pub const TestRun = struct {
    /// Indicates whether the test run targets resources in a single AWS account or
    /// across multiple accounts.
    account_targeting: ?AccountTargeting = null,

    /// The timestamp when the test run ended.
    ended_at: ?i64 = null,

    /// A human-readable reason for test run failure. Only present when the status
    /// is FAILED or ERROR.
    error_message: ?[]const u8 = null,

    /// The number of events recorded for the test run. Use ListTestRunEvents to
    /// retrieve the details.
    event_count: ?i32 = null,

    /// The AWS Fault Injection Service (AWS FIS) experiments run as part of the
    /// test run.
    experiments: ?[]const ExperimentDetails = null,

    /// The logging configuration snapshotted from the test when the run was
    /// started.
    logging_configuration: ?LoggingConfiguration = null,

    /// The parameter values used for the test run.
    parameters: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The permission model snapshotted from the service when the run was started.
    permission_model: ?PermissionModel = null,

    /// The resilience policy snapshotted from the service when the run was started.
    policy: ?TestRunPolicySnapshot = null,

    /// The Regions snapshotted from the service when the run was started.
    regions: ?[]const []const u8 = null,

    /// The identifier of the ARC Region switch execution detected during the test
    /// run.
    region_switch_execution_id: ?[]const u8 = null,

    /// The ARN of the ARC Region switch plan associated with the test run.
    region_switch_plan_arn: ?[]const u8 = null,

    /// The report configuration snapshotted from the service when the run was
    /// started.
    report_configuration: ?TestRunReportConfiguration = null,

    /// The report generation result for the test run. Present after report
    /// generation completes or fails.
    report_output: ?ReportGenerationResult = null,

    /// The IAM execution role name snapshotted from the test when the run was
    /// started.
    role_name: ?[]const u8 = null,

    /// The ARN of the service the test run belongs to.
    service_arn: ?[]const u8 = null,

    /// The timestamp when the test run started.
    started_at: i64,

    /// The current status of the test run.
    status: TestRunStatus,

    /// The stop conditions snapshotted from the test when the run was started.
    stop_conditions: ?[]const StopCondition = null,

    /// The identifier of the test that was run.
    test_id: []const u8,

    /// The unique identifier of the test run.
    test_run_id: []const u8,

    /// The ARN of the test template snapshotted from the test when the run was
    /// started.
    test_template_arn: []const u8,

    pub const json_field_names = .{
        .account_targeting = "accountTargeting",
        .ended_at = "endedAt",
        .error_message = "errorMessage",
        .event_count = "eventCount",
        .experiments = "experiments",
        .logging_configuration = "loggingConfiguration",
        .parameters = "parameters",
        .permission_model = "permissionModel",
        .policy = "policy",
        .regions = "regions",
        .region_switch_execution_id = "regionSwitchExecutionId",
        .region_switch_plan_arn = "regionSwitchPlanArn",
        .report_configuration = "reportConfiguration",
        .report_output = "reportOutput",
        .role_name = "roleName",
        .service_arn = "serviceArn",
        .started_at = "startedAt",
        .status = "status",
        .stop_conditions = "stopConditions",
        .test_id = "testId",
        .test_run_id = "testRunId",
        .test_template_arn = "testTemplateArn",
    };
};
