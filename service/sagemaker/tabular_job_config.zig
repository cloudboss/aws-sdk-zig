const CandidateGenerationConfig = @import("candidate_generation_config.zig").CandidateGenerationConfig;
const AutoMLJobCompletionCriteria = @import("auto_ml_job_completion_criteria.zig").AutoMLJobCompletionCriteria;
const AutoMLMode = @import("auto_ml_mode.zig").AutoMLMode;
const ProblemType = @import("problem_type.zig").ProblemType;

/// The collection of settings used by an AutoML job V2 for the tabular problem
/// type.
pub const TabularJobConfig = struct {
    /// The configuration information of how model candidates are generated.
    candidate_generation_config: ?CandidateGenerationConfig = null,

    completion_criteria: ?AutoMLJobCompletionCriteria = null,

    /// A URL to the Amazon S3 data source containing selected features from the
    /// input data source to run an Autopilot job V2. You can input
    /// `FeatureAttributeNames` (optional) in JSON format as shown below:
    ///
    /// `{ "FeatureAttributeNames":["col1", "col2", ...] }`.
    ///
    /// You can also specify the data type of the feature (optional) in the format
    /// shown below:
    ///
    /// `{ "FeatureDataTypes":{"col1":"numeric", "col2":"categorical" ... } }`
    ///
    /// These column keys may not include the target column.
    ///
    /// In ensembling mode, Autopilot only supports the following data types:
    /// `numeric`, `categorical`, `text`, and `datetime`. In HPO mode, Autopilot can
    /// support `numeric`, `categorical`, `text`, `datetime`, and `sequence`.
    ///
    /// If only `FeatureDataTypes` is provided, the column keys (`col1`, `col2`,..)
    /// should be a subset of the column names in the input data.
    ///
    /// If both `FeatureDataTypes` and `FeatureAttributeNames` are provided, then
    /// the column keys should be a subset of the column names provided in
    /// `FeatureAttributeNames`.
    ///
    /// The key name `FeatureAttributeNames` is fixed. The values listed in
    /// `["col1", "col2", ...]` are case sensitive and should be a list of strings
    /// containing unique values that are a subset of the column names in the input
    /// data. The list of columns provided must not include the target column.
    feature_specification_s3_uri: ?[]const u8 = null,

    /// Generates possible candidates without training the models. A model candidate
    /// is a combination of data preprocessors, algorithms, and algorithm parameter
    /// settings.
    generate_candidate_definitions_only: ?bool = null,

    /// The method that Autopilot uses to train the data. You can either specify the
    /// mode manually or let Autopilot choose for you based on the dataset size by
    /// selecting `AUTO`. In `AUTO` mode, Autopilot chooses `ENSEMBLING` for
    /// datasets smaller than 100 MB, and `HYPERPARAMETER_TUNING` for larger ones.
    ///
    /// The `ENSEMBLING` mode uses a multi-stack ensemble model to predict
    /// classification and regression tasks directly from your dataset. This machine
    /// learning mode combines several base models to produce an optimal predictive
    /// model. It then uses a stacking ensemble method to combine predictions from
    /// contributing members. A multi-stack ensemble model can provide better
    /// performance over a single model by combining the predictive capabilities of
    /// multiple models. See [Autopilot algorithm
    /// support](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-model-support-validation.html#autopilot-algorithm-support) for a list of algorithms supported by `ENSEMBLING` mode.
    ///
    /// The `HYPERPARAMETER_TUNING` (HPO) mode uses the best hyperparameters to
    /// train the best version of a model. HPO automatically selects an algorithm
    /// for the type of problem you want to solve. Then HPO finds the best
    /// hyperparameters according to your objective metric. See [Autopilot algorithm
    /// support](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-model-support-validation.html#autopilot-algorithm-support) for a list of algorithms supported by `HYPERPARAMETER_TUNING` mode.
    mode: ?AutoMLMode = null,

    /// The type of supervised learning problem available for the model candidates
    /// of the AutoML job V2. For more information, see [ SageMaker Autopilot
    /// problem
    /// types](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-datasets-problem-types.html#autopilot-problem-types).
    ///
    /// You must either specify the type of supervised learning problem in
    /// `ProblemType` and provide the
    /// [AutoMLJobObjective](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateAutoMLJobV2.html#sagemaker-CreateAutoMLJobV2-request-AutoMLJobObjective) metric, or none at all.
    problem_type: ?ProblemType = null,

    /// If specified, this column name indicates which column of the dataset should
    /// be treated as sample weights for use by the objective metric during the
    /// training, evaluation, and the selection of the best model. This column is
    /// not considered as a predictive feature. For more information on Autopilot
    /// metrics, see [Metrics and
    /// validation](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-metrics-validation.html).
    ///
    /// Sample weights should be numeric, non-negative, with larger values
    /// indicating which rows are more important than others. Data points that have
    /// invalid or no weight value are excluded.
    ///
    /// Support for sample weights is available in
    /// [Ensembling](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AutoMLAlgorithmConfig.html) mode only.
    sample_weight_attribute_name: ?[]const u8 = null,

    /// The name of the target variable in supervised learning, usually represented
    /// by 'y'.
    target_attribute_name: []const u8,

    pub const json_field_names = .{
        .candidate_generation_config = "CandidateGenerationConfig",
        .completion_criteria = "CompletionCriteria",
        .feature_specification_s3_uri = "FeatureSpecificationS3Uri",
        .generate_candidate_definitions_only = "GenerateCandidateDefinitionsOnly",
        .mode = "Mode",
        .problem_type = "ProblemType",
        .sample_weight_attribute_name = "SampleWeightAttributeName",
        .target_attribute_name = "TargetAttributeName",
    };
};
