const aws = @import("aws");

const ExperimentAction = @import("experiment_action.zig").ExperimentAction;
const ExperimentOptions = @import("experiment_options.zig").ExperimentOptions;
const ExperimentReport = @import("experiment_report.zig").ExperimentReport;
const ExperimentReportConfiguration = @import("experiment_report_configuration.zig").ExperimentReportConfiguration;
const ExperimentLogConfiguration = @import("experiment_log_configuration.zig").ExperimentLogConfiguration;
const ExperimentState = @import("experiment_state.zig").ExperimentState;
const ExperimentStopCondition = @import("experiment_stop_condition.zig").ExperimentStopCondition;
const ExperimentTarget = @import("experiment_target.zig").ExperimentTarget;

/// Describes an experiment.
pub const Experiment = struct {
    /// The actions for the experiment.
    actions: ?[]const aws.map.MapEntry(ExperimentAction),

    /// The Amazon Resource Name (ARN) of the experiment.
    arn: ?[]const u8,

    /// The time that the experiment was created.
    creation_time: ?i64,

    /// The time that the experiment ended.
    end_time: ?i64,

    /// The experiment options for the experiment.
    experiment_options: ?ExperimentOptions,

    /// The experiment report for the experiment.
    experiment_report: ?ExperimentReport,

    /// The experiment report configuration for the experiment.
    experiment_report_configuration: ?ExperimentReportConfiguration,

    /// The ID of the experiment template.
    experiment_template_id: ?[]const u8,

    /// The ID of the experiment.
    id: ?[]const u8,

    /// The configuration for experiment logging.
    log_configuration: ?ExperimentLogConfiguration,

    /// The Amazon Resource Name (ARN) of an IAM role that grants the FIS service
    /// permission to perform service actions on your behalf.
    role_arn: ?[]const u8,

    /// The time that the experiment started.
    start_time: ?i64,

    /// The state of the experiment.
    state: ?ExperimentState,

    /// The stop conditions for the experiment.
    stop_conditions: ?[]const ExperimentStopCondition,

    /// The tags for the experiment.
    tags: ?[]const aws.map.StringMapEntry,

    /// The count of target account configurations for the experiment.
    target_account_configurations_count: ?i64,

    /// The targets for the experiment.
    targets: ?[]const aws.map.MapEntry(ExperimentTarget),

    pub const json_field_names = .{
        .actions = "actions",
        .arn = "arn",
        .creation_time = "creationTime",
        .end_time = "endTime",
        .experiment_options = "experimentOptions",
        .experiment_report = "experimentReport",
        .experiment_report_configuration = "experimentReportConfiguration",
        .experiment_template_id = "experimentTemplateId",
        .id = "id",
        .log_configuration = "logConfiguration",
        .role_arn = "roleArn",
        .start_time = "startTime",
        .state = "state",
        .stop_conditions = "stopConditions",
        .tags = "tags",
        .target_account_configurations_count = "targetAccountConfigurationsCount",
        .targets = "targets",
    };
};
