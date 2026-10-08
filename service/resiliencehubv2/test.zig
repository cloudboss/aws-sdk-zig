const aws = @import("aws");

const TestAction = @import("test_action.zig").TestAction;
const LoggingConfiguration = @import("logging_configuration.zig").LoggingConfiguration;
const StopCondition = @import("stop_condition.zig").StopCondition;

/// Represents a test created for a service by configuring a test template.
pub const Test = struct {
    /// The fault actions the test runs.
    actions: ?[]const TestAction = null,

    /// The timestamp when the test was created.
    creation_time: i64,

    /// The logging configuration for the test.
    logging_configuration: ?LoggingConfiguration = null,

    /// The name of the test.
    name: []const u8,

    /// The parameter values configured for the test.
    parameters: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The name of the IAM execution role used to run the test.
    role_name: ?[]const u8 = null,

    /// The ARN of the service the test belongs to.
    service_arn: []const u8,

    /// The stop conditions for the test.
    stop_conditions: ?[]const StopCondition = null,

    /// The number of successful runs of the test.
    successful_test_runs: i32,

    /// The unique identifier of the test.
    test_id: []const u8,

    /// The ARN of the test template the test was created from.
    test_template_arn: []const u8,

    /// The total number of runs of the test.
    total_test_runs: i32,

    pub const json_field_names = .{
        .actions = "actions",
        .creation_time = "creationTime",
        .logging_configuration = "loggingConfiguration",
        .name = "name",
        .parameters = "parameters",
        .role_name = "roleName",
        .service_arn = "serviceArn",
        .stop_conditions = "stopConditions",
        .successful_test_runs = "successfulTestRuns",
        .test_id = "testId",
        .test_template_arn = "testTemplateArn",
        .total_test_runs = "totalTestRuns",
    };
};
