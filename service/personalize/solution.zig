const AutoMLResult = @import("auto_ml_result.zig").AutoMLResult;
const SolutionUpdateSummary = @import("solution_update_summary.zig").SolutionUpdateSummary;
const SolutionVersionSummary = @import("solution_version_summary.zig").SolutionVersionSummary;
const SolutionConfig = @import("solution_config.zig").SolutionConfig;

/// By default, all new solutions use automatic training. With automatic
/// training, you incur training costs while
/// your solution is active. To avoid unnecessary costs, when you are finished
/// you can
/// [update the
/// solution](https://docs.aws.amazon.com/personalize/latest/dg/API_UpdateSolution.html) to turn off automatic training.
/// For information about training
/// costs, see [Amazon Personalize
/// pricing](https://aws.amazon.com/personalize/pricing/).
///
/// An object that provides information about a solution. A solution includes
/// the custom recipe, customized parameters, and
/// trained models (Solution Versions) that Amazon Personalize uses to generate
/// recommendations.
///
/// After you create a solution, you can’t change its configuration. If you need
/// to make changes, you can [clone the
/// solution](https://docs.aws.amazon.com/personalize/latest/dg/cloning-solution.html) with the Amazon Personalize console
/// or create a new one.
pub const Solution = struct {
    /// When `performAutoML` is true, specifies the best recipe found.
    auto_ml_result: ?AutoMLResult = null,

    /// The creation date and time (in Unix time) of the solution.
    creation_date_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the dataset group that provides the
    /// training data.
    dataset_group_arn: ?[]const u8 = null,

    /// The event type (for example, 'click' or 'like') that is used for training
    /// the model.
    /// If no `eventType` is provided, Amazon Personalize uses all interactions for
    /// training with
    /// equal weight regardless of type.
    event_type: ?[]const u8 = null,

    /// The date and time (in Unix time) that the solution was last updated.
    last_updated_date_time: ?i64 = null,

    /// Provides a summary of the latest updates to the solution.
    latest_solution_update: ?SolutionUpdateSummary = null,

    /// Describes the latest version of the solution, including the status and the
    /// ARN.
    latest_solution_version: ?SolutionVersionSummary = null,

    /// The name of the solution.
    name: ?[]const u8 = null,

    /// We don't recommend enabling automated machine learning. Instead, match your
    /// use case to the available Amazon Personalize
    /// recipes. For more information, see [Determining your use
    /// case.](https://docs.aws.amazon.com/personalize/latest/dg/determining-use-case.html)
    ///
    /// When true, Amazon Personalize performs a search for the best
    /// USER_PERSONALIZATION recipe from
    /// the list specified in the solution configuration (`recipeArn` must not be
    /// specified).
    /// When false (the default), Amazon Personalize uses `recipeArn` for training.
    perform_auto_ml: bool = false,

    /// Specifies whether the solution automatically creates solution versions. The
    /// default is `True`
    /// and the solution automatically creates new solution versions every 7 days.
    ///
    /// For more information about auto training, see [Creating and configuring a
    /// solution](https://docs.aws.amazon.com/personalize/latest/dg/customizing-solution-config.html).
    perform_auto_training: ?bool = null,

    /// Whether to perform hyperparameter optimization (HPO) on the chosen recipe.
    /// The
    /// default is `false`.
    perform_hpo: bool = false,

    /// A Boolean value that indicates whether incremental training updates are
    /// performed on the model. When enabled, this allows the model to learn from
    /// new data more frequently without requiring full retraining, which enables
    /// near real-time personalization. This parameter is supported only for
    /// solutions that use the semantic-similarity recipe
    perform_incremental_update: ?bool = null,

    /// The ARN of the recipe used to create the solution. This is required when
    /// `performAutoML` is false.
    recipe_arn: ?[]const u8 = null,

    /// The ARN of the solution.
    solution_arn: ?[]const u8 = null,

    /// Describes the configuration properties for the solution.
    solution_config: ?SolutionConfig = null,

    /// The status of the solution.
    ///
    /// A solution can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .auto_ml_result = "autoMLResult",
        .creation_date_time = "creationDateTime",
        .dataset_group_arn = "datasetGroupArn",
        .event_type = "eventType",
        .last_updated_date_time = "lastUpdatedDateTime",
        .latest_solution_update = "latestSolutionUpdate",
        .latest_solution_version = "latestSolutionVersion",
        .name = "name",
        .perform_auto_ml = "performAutoML",
        .perform_auto_training = "performAutoTraining",
        .perform_hpo = "performHPO",
        .perform_incremental_update = "performIncrementalUpdate",
        .recipe_arn = "recipeArn",
        .solution_arn = "solutionArn",
        .solution_config = "solutionConfig",
        .status = "status",
    };
};
