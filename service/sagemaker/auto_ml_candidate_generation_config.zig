const AutoMLAlgorithmConfig = @import("auto_ml_algorithm_config.zig").AutoMLAlgorithmConfig;

/// Stores the configuration information for how a candidate is generated
/// (optional).
pub const AutoMLCandidateGenerationConfig = struct {
    /// Stores the configuration information for the selection of algorithms trained
    /// on tabular data.
    ///
    /// The list of available algorithms to choose from depends on the training mode
    /// set in [ `TabularJobConfig.Mode`
    /// ](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_TabularJobConfig.html).
    ///
    /// * `AlgorithmsConfig` should not be set if the training mode is set on
    ///   `AUTO`.
    /// * When `AlgorithmsConfig` is provided, one `AutoMLAlgorithms` attribute must
    ///   be set and one only.
    ///
    /// If the list of algorithms provided as values for `AutoMLAlgorithms` is
    /// empty, `CandidateGenerationConfig` uses the full set of algorithms for the
    /// given training mode.
    /// * When `AlgorithmsConfig` is not provided, `CandidateGenerationConfig` uses
    ///   the full set of algorithms for the given training mode.
    ///
    /// For the list of all algorithms per problem type and training mode, see [
    /// AutoMLAlgorithmConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AutoMLAlgorithmConfig.html).
    ///
    /// For more information on each algorithm, see the [Algorithm
    /// support](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-model-support-validation.html#autopilot-algorithm-support) section in Autopilot developer guide.
    algorithms_config: ?[]const AutoMLAlgorithmConfig,

    /// A URL to the Amazon S3 data source containing selected features from the
    /// input data source to run an Autopilot job. You can input
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
    feature_specification_s3_uri: ?[]const u8,

    pub const json_field_names = .{
        .algorithms_config = "AlgorithmsConfig",
        .feature_specification_s3_uri = "FeatureSpecificationS3Uri",
    };
};
