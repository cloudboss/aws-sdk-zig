const aws = @import("aws");

const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const AutomationExecutionStatus = @import("automation_execution_status.zig").AutomationExecutionStatus;
const AutomationSubtype = @import("automation_subtype.zig").AutomationSubtype;
const ExecutionMode = @import("execution_mode.zig").ExecutionMode;
const ProgressCounters = @import("progress_counters.zig").ProgressCounters;
const ResolvedTargets = @import("resolved_targets.zig").ResolvedTargets;
const Runbook = @import("runbook.zig").Runbook;
const StepExecution = @import("step_execution.zig").StepExecution;
const TargetLocation = @import("target_location.zig").TargetLocation;
const Target = @import("target.zig").Target;
const AlarmStateInformation = @import("alarm_state_information.zig").AlarmStateInformation;

/// Detailed information about the current state of an individual Automation
/// execution.
pub const AutomationExecution = struct {
    /// The details for the CloudWatch alarm applied to your automation.
    alarm_configuration: ?AlarmConfiguration,

    /// The ID of a State Manager association used in the Automation operation.
    association_id: ?[]const u8,

    /// The execution ID.
    automation_execution_id: ?[]const u8,

    /// The execution status of the Automation.
    automation_execution_status: ?AutomationExecutionStatus,

    /// The subtype of the Automation operation. Currently, the only supported value
    /// is
    /// `ChangeRequest`.
    automation_subtype: ?AutomationSubtype,

    /// The name of the Change Manager change request.
    change_request_name: ?[]const u8,

    /// The action of the step that is currently running.
    current_action: ?[]const u8,

    /// The name of the step that is currently running.
    current_step_name: ?[]const u8,

    /// The name of the Automation runbook used during the execution.
    document_name: ?[]const u8,

    /// The version of the document to use during execution.
    document_version: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the user who ran the automation.
    executed_by: ?[]const u8,

    /// The time the execution finished.
    execution_end_time: ?i64,

    /// The time the execution started.
    execution_start_time: ?i64,

    /// A message describing why an execution has failed, if the status is set to
    /// Failed.
    failure_message: ?[]const u8,

    /// The `MaxConcurrency` value specified by the user when the execution
    /// started.
    max_concurrency: ?[]const u8,

    /// The MaxErrors value specified by the user when the execution started.
    max_errors: ?[]const u8,

    /// The automation execution mode.
    mode: ?ExecutionMode,

    /// The ID of an OpsItem that is created to represent a Change Manager change
    /// request.
    ops_item_id: ?[]const u8,

    /// The list of execution outputs as defined in the Automation runbook.
    outputs: ?[]const aws.map.MapEntry([]const []const u8),

    /// The key-value map of execution parameters, which were supplied when calling
    /// StartAutomationExecution.
    parameters: ?[]const aws.map.MapEntry([]const []const u8),

    /// The AutomationExecutionId of the parent automation.
    parent_automation_execution_id: ?[]const u8,

    /// An aggregate of step execution statuses displayed in the Amazon Web Services
    /// Systems Manager console for a
    /// multi-Region and multi-account Automation execution.
    progress_counters: ?ProgressCounters,

    /// A list of resolved targets in the rate control execution.
    resolved_targets: ?ResolvedTargets,

    /// Information about the Automation runbooks that are run as part of a runbook
    /// workflow.
    ///
    /// The Automation runbooks specified for the runbook workflow can't run until
    /// all required
    /// approvals for the change request have been received.
    runbooks: ?[]const Runbook,

    /// The date and time the Automation operation is scheduled to start.
    scheduled_time: ?i64,

    /// A list of details about the current state of all steps that comprise an
    /// execution. An
    /// Automation runbook contains a list of steps that are run in order.
    step_executions: ?[]const StepExecution,

    /// A boolean value that indicates if the response contains the full list of the
    /// Automation step
    /// executions. If true, use the DescribeAutomationStepExecutions API operation
    /// to get the full list
    /// of step executions.
    step_executions_truncated: bool = false,

    /// The target of the execution.
    target: ?[]const u8,

    /// The combination of Amazon Web Services Regions and/or Amazon Web Services
    /// accounts where you want to run the
    /// Automation.
    target_locations: ?[]const TargetLocation,

    /// A publicly accessible URL for a file that contains the `TargetLocations`
    /// body.
    /// Currently, only files in presigned Amazon S3 buckets are supported
    target_locations_url: ?[]const u8,

    /// The specified key-value mapping of document parameters to target resources.
    target_maps: ?[]const []const aws.map.MapEntry([]const []const u8),

    /// The parameter name.
    target_parameter_name: ?[]const u8,

    /// The specified targets.
    targets: ?[]const Target,

    /// The CloudWatch alarm that was invoked by the automation.
    triggered_alarms: ?[]const AlarmStateInformation,

    /// Variables defined for the automation.
    variables: ?[]const aws.map.MapEntry([]const []const u8),

    pub const json_field_names = .{
        .alarm_configuration = "AlarmConfiguration",
        .association_id = "AssociationId",
        .automation_execution_id = "AutomationExecutionId",
        .automation_execution_status = "AutomationExecutionStatus",
        .automation_subtype = "AutomationSubtype",
        .change_request_name = "ChangeRequestName",
        .current_action = "CurrentAction",
        .current_step_name = "CurrentStepName",
        .document_name = "DocumentName",
        .document_version = "DocumentVersion",
        .executed_by = "ExecutedBy",
        .execution_end_time = "ExecutionEndTime",
        .execution_start_time = "ExecutionStartTime",
        .failure_message = "FailureMessage",
        .max_concurrency = "MaxConcurrency",
        .max_errors = "MaxErrors",
        .mode = "Mode",
        .ops_item_id = "OpsItemId",
        .outputs = "Outputs",
        .parameters = "Parameters",
        .parent_automation_execution_id = "ParentAutomationExecutionId",
        .progress_counters = "ProgressCounters",
        .resolved_targets = "ResolvedTargets",
        .runbooks = "Runbooks",
        .scheduled_time = "ScheduledTime",
        .step_executions = "StepExecutions",
        .step_executions_truncated = "StepExecutionsTruncated",
        .target = "Target",
        .target_locations = "TargetLocations",
        .target_locations_url = "TargetLocationsURL",
        .target_maps = "TargetMaps",
        .target_parameter_name = "TargetParameterName",
        .targets = "Targets",
        .triggered_alarms = "TriggeredAlarms",
        .variables = "Variables",
    };
};
