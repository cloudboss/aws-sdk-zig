const aws = @import("aws");

const ExperimentTemplateAction = @import("experiment_template_action.zig").ExperimentTemplateAction;
const ExperimentTemplateExperimentOptions = @import("experiment_template_experiment_options.zig").ExperimentTemplateExperimentOptions;
const ExperimentTemplateReportConfiguration = @import("experiment_template_report_configuration.zig").ExperimentTemplateReportConfiguration;
const ExperimentTemplateLogConfiguration = @import("experiment_template_log_configuration.zig").ExperimentTemplateLogConfiguration;
const ExperimentTemplateStopCondition = @import("experiment_template_stop_condition.zig").ExperimentTemplateStopCondition;
const ExperimentTemplateTarget = @import("experiment_template_target.zig").ExperimentTemplateTarget;

/// Describes an experiment template.
pub const ExperimentTemplate = struct {
    /// The actions for the experiment.
    actions: ?[]const aws.map.MapEntry(ExperimentTemplateAction) = null,

    /// The Amazon Resource Name (ARN) of the experiment template.
    arn: ?[]const u8 = null,

    /// The time the experiment template was created.
    creation_time: ?i64 = null,

    /// The description for the experiment template.
    description: ?[]const u8 = null,

    /// The experiment options for an experiment template.
    experiment_options: ?ExperimentTemplateExperimentOptions = null,

    /// Describes the report configuration for the experiment template.
    experiment_report_configuration: ?ExperimentTemplateReportConfiguration = null,

    /// The ID of the experiment template.
    id: ?[]const u8 = null,

    /// The time the experiment template was last updated.
    last_update_time: ?i64 = null,

    /// The configuration for experiment logging.
    log_configuration: ?ExperimentTemplateLogConfiguration = null,

    /// The Amazon Resource Name (ARN) of an IAM role.
    role_arn: ?[]const u8 = null,

    /// The stop conditions for the experiment.
    stop_conditions: ?[]const ExperimentTemplateStopCondition = null,

    /// The tags for the experiment template.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The count of target account configurations for the experiment template.
    target_account_configurations_count: ?i64 = null,

    /// The targets for the experiment.
    targets: ?[]const aws.map.MapEntry(ExperimentTemplateTarget) = null,

    pub const json_field_names = .{
        .actions = "actions",
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .experiment_options = "experimentOptions",
        .experiment_report_configuration = "experimentReportConfiguration",
        .id = "id",
        .last_update_time = "lastUpdateTime",
        .log_configuration = "logConfiguration",
        .role_arn = "roleArn",
        .stop_conditions = "stopConditions",
        .tags = "tags",
        .target_account_configurations_count = "targetAccountConfigurationsCount",
        .targets = "targets",
    };
};
