const aws = @import("aws");

const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const AutomationExecutionStatus = @import("automation_execution_status.zig").AutomationExecutionStatus;
const AutomationSubtype = @import("automation_subtype.zig").AutomationSubtype;
const AutomationType = @import("automation_type.zig").AutomationType;
const ExecutionMode = @import("execution_mode.zig").ExecutionMode;
const ResolvedTargets = @import("resolved_targets.zig").ResolvedTargets;
const Runbook = @import("runbook.zig").Runbook;
const Target = @import("target.zig").Target;
const AlarmStateInformation = @import("alarm_state_information.zig").AlarmStateInformation;

/// Details about a specific Automation execution.
pub const AutomationExecutionMetadata = struct {
    /// The details for the CloudWatch alarm applied to your automation.
    alarm_configuration: ?AlarmConfiguration,

    /// The ID of a State Manager association used in the Automation operation.
    association_id: ?[]const u8,

    /// The execution ID.
    automation_execution_id: ?[]const u8,

    /// The status of the execution.
    automation_execution_status: ?AutomationExecutionStatus,

    /// The subtype of the Automation operation. Currently, the only supported value
    /// is
    /// `ChangeRequest`.
    automation_subtype: ?AutomationSubtype,

    /// Use this filter with DescribeAutomationExecutions. Specify either Local or
    /// CrossAccount. CrossAccount is an Automation that runs in multiple Amazon Web
    /// Services Regions and
    /// Amazon Web Services accounts. For more information, see [Running automations
    /// in multiple Amazon Web Services Regions and
    /// accounts](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-automation-multiple-accounts-and-regions.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    automation_type: ?AutomationType,

    /// The name of the Change Manager change request.
    change_request_name: ?[]const u8,

    /// The action of the step that is currently running.
    current_action: ?[]const u8,

    /// The name of the step that is currently running.
    current_step_name: ?[]const u8,

    /// The name of the Automation runbook used during execution.
    document_name: ?[]const u8,

    /// The document version used during the execution.
    document_version: ?[]const u8,

    /// The IAM role ARN of the user who ran the automation.
    executed_by: ?[]const u8,

    /// The time the execution finished. This isn't populated if the execution is
    /// still in
    /// progress.
    execution_end_time: ?i64,

    /// The time the execution started.
    execution_start_time: ?i64,

    /// The list of execution outputs as defined in the Automation runbook.
    failure_message: ?[]const u8,

    /// An S3 bucket where execution information is stored.
    log_file: ?[]const u8,

    /// The `MaxConcurrency` value specified by the user when starting the
    /// automation.
    max_concurrency: ?[]const u8,

    /// The `MaxErrors` value specified by the user when starting the automation.
    max_errors: ?[]const u8,

    /// The Automation execution mode.
    mode: ?ExecutionMode,

    /// The ID of an OpsItem that is created to represent a Change Manager change
    /// request.
    ops_item_id: ?[]const u8,

    /// The list of execution outputs as defined in the Automation runbook.
    outputs: ?[]const aws.map.MapEntry([]const []const u8),

    /// The execution ID of the parent automation.
    parent_automation_execution_id: ?[]const u8,

    /// A list of targets that resolved during the execution.
    resolved_targets: ?ResolvedTargets,

    /// Information about the Automation runbooks that are run during a runbook
    /// workflow in
    /// Change Manager.
    ///
    /// **Note:**
    ///
    /// The Automation runbooks specified for the runbook workflow can't run until
    /// all required
    /// approvals for the change request have been received.
    runbooks: ?[]const Runbook,

    /// The date and time the Automation operation is scheduled to start.
    scheduled_time: ?i64,

    /// The list of execution outputs as defined in the Automation runbook.
    target: ?[]const u8,

    /// A publicly accessible URL for a file that contains the `TargetLocations`
    /// body.
    /// Currently, only files in presigned Amazon S3 buckets are supported
    target_locations_url: ?[]const u8,

    /// The specified key-value mapping of document parameters to target resources.
    target_maps: ?[]const []const aws.map.MapEntry([]const []const u8),

    /// The list of execution outputs as defined in the Automation runbook.
    target_parameter_name: ?[]const u8,

    /// The targets defined by the user when starting the automation.
    targets: ?[]const Target,

    /// The CloudWatch alarm that was invoked by the automation.
    triggered_alarms: ?[]const AlarmStateInformation,

    pub const json_field_names = .{
        .alarm_configuration = "AlarmConfiguration",
        .association_id = "AssociationId",
        .automation_execution_id = "AutomationExecutionId",
        .automation_execution_status = "AutomationExecutionStatus",
        .automation_subtype = "AutomationSubtype",
        .automation_type = "AutomationType",
        .change_request_name = "ChangeRequestName",
        .current_action = "CurrentAction",
        .current_step_name = "CurrentStepName",
        .document_name = "DocumentName",
        .document_version = "DocumentVersion",
        .executed_by = "ExecutedBy",
        .execution_end_time = "ExecutionEndTime",
        .execution_start_time = "ExecutionStartTime",
        .failure_message = "FailureMessage",
        .log_file = "LogFile",
        .max_concurrency = "MaxConcurrency",
        .max_errors = "MaxErrors",
        .mode = "Mode",
        .ops_item_id = "OpsItemId",
        .outputs = "Outputs",
        .parent_automation_execution_id = "ParentAutomationExecutionId",
        .resolved_targets = "ResolvedTargets",
        .runbooks = "Runbooks",
        .scheduled_time = "ScheduledTime",
        .target = "Target",
        .target_locations_url = "TargetLocationsURL",
        .target_maps = "TargetMaps",
        .target_parameter_name = "TargetParameterName",
        .targets = "Targets",
        .triggered_alarms = "TriggeredAlarms",
    };
};
