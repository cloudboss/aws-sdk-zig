/// Specifies a metric that the training algorithm writes to `stderr` or
/// `stdout`. You can view these logs to understand how your training job
/// performs and check for any errors encountered during training. SageMaker
/// hyperparameter tuning captures all defined metrics. Specify one of the
/// defined metrics to use as an objective metric using the
/// [TuningObjective](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTrainingJobDefinition.html#sagemaker-Type-HyperParameterTrainingJobDefinition-TuningObjective) parameter in the `HyperParameterTrainingJobDefinition` API to evaluate job performance during hyperparameter tuning.
pub const MetricDefinition = struct {
    /// The name of the metric.
    name: []const u8,

    /// A regular expression that searches the output of a training job and gets the
    /// value of the metric. For more information about using regular expressions to
    /// define metrics, see [Defining metrics and environment
    /// variables](https://docs.aws.amazon.com/sagemaker/latest/dg/automatic-model-tuning-define-metrics-variables.html).
    regex: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .regex = "Regex",
    };
};
