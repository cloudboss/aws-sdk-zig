const ExperimentSource = @import("experiment_source.zig").ExperimentSource;

/// A summary of the properties of an experiment. To get the complete set of
/// properties, call the
/// [DescribeExperiment](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeExperiment.html) API and provide the `ExperimentName`.
pub const ExperimentSummary = struct {
    /// When the experiment was created.
    creation_time: ?i64 = null,

    /// The name of the experiment as displayed. If `DisplayName` isn't specified,
    /// `ExperimentName` is displayed.
    display_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the experiment.
    experiment_arn: ?[]const u8 = null,

    /// The name of the experiment.
    experiment_name: ?[]const u8 = null,

    experiment_source: ?ExperimentSource = null,

    /// When the experiment was last modified.
    last_modified_time: ?i64 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .display_name = "DisplayName",
        .experiment_arn = "ExperimentArn",
        .experiment_name = "ExperimentName",
        .experiment_source = "ExperimentSource",
        .last_modified_time = "LastModifiedTime",
    };
};
