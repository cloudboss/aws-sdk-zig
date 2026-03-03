const aws = @import("aws");

/// Measurements of how well the `MLModel` performed on known observations. One
/// of the following metrics is returned, based on the type of the `MLModel`:
///
/// * BinaryAUC: The binary `MLModel` uses the Area Under the Curve (AUC)
///   technique to measure performance.
///
/// * RegressionRMSE: The regression `MLModel` uses the Root Mean Square Error
///   (RMSE) technique to measure performance. RMSE measures the difference
///   between predicted and actual values for a single variable.
///
/// * MulticlassAvgFScore: The multiclass `MLModel` uses the F1 score technique
///   to measure performance.
///
/// For more information about performance metrics, please see the [Amazon
/// Machine Learning Developer
/// Guide](https://docs.aws.amazon.com/machine-learning/latest/dg).
pub const PerformanceMetrics = struct {
    properties: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .properties = "Properties",
    };
};
