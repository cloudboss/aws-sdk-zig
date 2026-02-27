const aws = @import("aws");

const ExperimentOptions = @import("experiment_options.zig").ExperimentOptions;
const ExperimentState = @import("experiment_state.zig").ExperimentState;

/// Provides a summary of an experiment.
pub const ExperimentSummary = struct {
    /// The Amazon Resource Name (ARN) of the experiment.
    arn: ?[]const u8,

    /// The time that the experiment was created.
    creation_time: ?i64,

    /// The experiment options for the experiment.
    experiment_options: ?ExperimentOptions,

    /// The ID of the experiment template.
    experiment_template_id: ?[]const u8,

    /// The ID of the experiment.
    id: ?[]const u8,

    /// The state of the experiment.
    state: ?ExperimentState,

    /// The tags for the experiment.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .experiment_options = "experimentOptions",
        .experiment_template_id = "experimentTemplateId",
        .id = "id",
        .state = "state",
        .tags = "tags",
    };
};
