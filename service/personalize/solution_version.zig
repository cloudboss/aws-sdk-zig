const SolutionConfig = @import("solution_config.zig").SolutionConfig;
const TrainingMode = @import("training_mode.zig").TrainingMode;
const TrainingType = @import("training_type.zig").TrainingType;
const TunedHPOParams = @import("tuned_hpo_params.zig").TunedHPOParams;

/// An object that provides information about a specific version of a
/// [Solution](https://docs.aws.amazon.com/personalize/latest/dg/API_Solution.html) in a Custom dataset group.
pub const SolutionVersion = struct {
    /// The date and
    /// time
    /// (in Unix time) that this version of the solution was created.
    creation_date_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the dataset group providing the training
    /// data.
    dataset_group_arn: ?[]const u8 = null,

    /// The event type (for example, 'click' or 'like') that is used for training
    /// the
    /// model.
    event_type: ?[]const u8 = null,

    /// If training a solution version fails, the reason for the failure.
    failure_reason: ?[]const u8 = null,

    /// The date and time (in
    /// Unix
    /// time) that the solution was last updated.
    last_updated_date_time: ?i64 = null,

    /// The name of the solution version.
    name: ?[]const u8 = null,

    /// When true, Amazon Personalize searches for the most optimal recipe according
    /// to the solution
    /// configuration. When false (the default), Amazon Personalize uses
    /// `recipeArn`.
    perform_auto_ml: bool = false,

    /// Whether to perform hyperparameter optimization (HPO) on the chosen recipe.
    /// The default is
    /// `false`.
    perform_hpo: bool = false,

    /// Whether the solution version should perform an incremental update. When set
    /// to true,
    /// the training will process only the data that has changed since the latest
    /// training, similar
    /// to when trainingMode is set to UPDATE. This can only be used with solution
    /// versions that
    /// use the User-Personalization recipe.
    perform_incremental_update: ?bool = null,

    /// The ARN of the recipe used in the solution.
    recipe_arn: ?[]const u8 = null,

    /// The ARN of the solution.
    solution_arn: ?[]const u8 = null,

    /// Describes the configuration properties for the solution.
    solution_config: ?SolutionConfig = null,

    /// The ARN of the solution version.
    solution_version_arn: ?[]const u8 = null,

    /// The status of the solution version.
    ///
    /// A solution version can be in one of the following states:
    ///
    /// * CREATE PENDING
    ///
    /// * CREATE IN_PROGRESS
    ///
    /// * ACTIVE
    ///
    /// * CREATE FAILED
    ///
    /// * CREATE STOPPING
    ///
    /// * CREATE STOPPED
    status: ?[]const u8 = null,

    /// The time used to train the model. You are billed for the time it takes to
    /// train a model.
    /// This field is visible only after Amazon Personalize successfully trains a
    /// model.
    training_hours: ?f64 = null,

    /// The scope of training to be performed when creating the solution version. A
    /// `FULL` training considers all of the data in your dataset group.
    /// An `UPDATE` processes only the data that
    /// has changed since the latest training. Only solution versions created with
    /// the User-Personalization
    /// recipe can use `UPDATE`.
    training_mode: ?TrainingMode = null,

    /// Whether the solution version was created automatically or manually.
    training_type: ?TrainingType = null,

    /// If hyperparameter optimization was performed, contains the hyperparameter
    /// values of the
    /// best performing model.
    tuned_hpo_params: ?TunedHPOParams = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .dataset_group_arn = "datasetGroupArn",
        .event_type = "eventType",
        .failure_reason = "failureReason",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .perform_auto_ml = "performAutoML",
        .perform_hpo = "performHPO",
        .perform_incremental_update = "performIncrementalUpdate",
        .recipe_arn = "recipeArn",
        .solution_arn = "solutionArn",
        .solution_config = "solutionConfig",
        .solution_version_arn = "solutionVersionArn",
        .status = "status",
        .training_hours = "trainingHours",
        .training_mode = "trainingMode",
        .training_type = "trainingType",
        .tuned_hpo_params = "tunedHPOParams",
    };
};
