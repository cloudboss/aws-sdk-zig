const aws = @import("aws");

const FailureDetails = @import("failure_details.zig").FailureDetails;
const ParentStepDetails = @import("parent_step_details.zig").ParentStepDetails;
const AutomationExecutionStatus = @import("automation_execution_status.zig").AutomationExecutionStatus;
const TargetLocation = @import("target_location.zig").TargetLocation;
const Target = @import("target.zig").Target;
const AlarmStateInformation = @import("alarm_state_information.zig").AlarmStateInformation;

/// Detailed information about an the execution state of an Automation step.
pub const StepExecution = struct {
    /// The action this step performs. The action determines the behavior of the
    /// step.
    action: ?[]const u8,

    /// If a step has finished execution, this contains the time the execution
    /// ended. If the step
    /// hasn't yet concluded, this field isn't populated.
    execution_end_time: ?i64,

    /// If a step has begun execution, this contains the time the step started. If
    /// the step is in
    /// Pending status, this field isn't populated.
    execution_start_time: ?i64,

    /// Information about the Automation failure.
    failure_details: ?FailureDetails,

    /// If a step failed, this message explains why the execution failed.
    failure_message: ?[]const u8,

    /// Fully-resolved values passed into the step before execution.
    inputs: ?[]const aws.map.StringMapEntry,

    /// The flag which can be used to help decide whether the failure of current
    /// step leads to the
    /// Automation failure.
    is_critical: ?bool,

    /// The flag which can be used to end automation no matter whether the step
    /// succeeds or
    /// fails.
    is_end: ?bool,

    /// The maximum number of tries to run the action of the step. The default value
    /// is
    /// `1`.
    max_attempts: ?i32,

    /// The next step after the step succeeds.
    next_step: ?[]const u8,

    /// The action to take if the step fails. The default value is `Abort`.
    on_failure: ?[]const u8,

    /// Returned values from the execution of the step.
    outputs: ?[]const aws.map.MapEntry([]const []const u8),

    /// A user-specified list of parameters to override when running a step.
    overridden_parameters: ?[]const aws.map.MapEntry([]const []const u8),

    /// Information about the parent step.
    parent_step_details: ?ParentStepDetails,

    /// A message associated with the response code for an execution.
    response: ?[]const u8,

    /// The response code returned by the execution of the step.
    response_code: ?[]const u8,

    /// The unique ID of a step execution.
    step_execution_id: ?[]const u8,

    /// The name of this execution step.
    step_name: ?[]const u8,

    /// The execution status for this step.
    step_status: ?AutomationExecutionStatus,

    /// The combination of Amazon Web Services Regions and Amazon Web Services
    /// accounts targeted by the current Automation
    /// execution.
    target_location: ?TargetLocation,

    /// The targets for the step execution.
    targets: ?[]const Target,

    /// The timeout seconds of the step.
    timeout_seconds: ?i64,

    /// The CloudWatch alarms that were invoked by the automation.
    triggered_alarms: ?[]const AlarmStateInformation,

    /// Strategies used when step fails, we support Continue and Abort. Abort will
    /// fail the
    /// automation when the step fails. Continue will ignore the failure of current
    /// step and allow
    /// automation to run the next step. With conditional branching, we add
    /// step:stepName to support the
    /// automation to go to another specific step.
    valid_next_steps: ?[]const []const u8,

    pub const json_field_names = .{
        .action = "Action",
        .execution_end_time = "ExecutionEndTime",
        .execution_start_time = "ExecutionStartTime",
        .failure_details = "FailureDetails",
        .failure_message = "FailureMessage",
        .inputs = "Inputs",
        .is_critical = "IsCritical",
        .is_end = "IsEnd",
        .max_attempts = "MaxAttempts",
        .next_step = "NextStep",
        .on_failure = "OnFailure",
        .outputs = "Outputs",
        .overridden_parameters = "OverriddenParameters",
        .parent_step_details = "ParentStepDetails",
        .response = "Response",
        .response_code = "ResponseCode",
        .step_execution_id = "StepExecutionId",
        .step_name = "StepName",
        .step_status = "StepStatus",
        .target_location = "TargetLocation",
        .targets = "Targets",
        .timeout_seconds = "TimeoutSeconds",
        .triggered_alarms = "TriggeredAlarms",
        .valid_next_steps = "ValidNextSteps",
    };
};
