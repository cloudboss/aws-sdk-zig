const UserContext = @import("user_context.zig").UserContext;
const ExperimentSource = @import("experiment_source.zig").ExperimentSource;
const Tag = @import("tag.zig").Tag;

/// The properties of an experiment as returned by the
/// [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API. For information about experiments, see the [CreateExperiment](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateExperiment.html) API.
pub const Experiment = struct {
    /// Who created the experiment.
    created_by: ?UserContext = null,

    /// When the experiment was created.
    creation_time: ?i64 = null,

    /// The description of the experiment.
    description: ?[]const u8 = null,

    /// The name of the experiment as displayed. If `DisplayName` isn't specified,
    /// `ExperimentName` is displayed.
    display_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the experiment.
    experiment_arn: ?[]const u8 = null,

    /// The name of the experiment.
    experiment_name: ?[]const u8 = null,

    last_modified_by: ?UserContext = null,

    /// When the experiment was last modified.
    last_modified_time: ?i64 = null,

    source: ?ExperimentSource = null,

    /// The list of tags that are associated with the experiment. You can use
    /// [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API to search on the tags.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .description = "Description",
        .display_name = "DisplayName",
        .experiment_arn = "ExperimentArn",
        .experiment_name = "ExperimentName",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .source = "Source",
        .tags = "Tags",
    };
};
