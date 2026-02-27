const ProcessingS3DataDistributionType = @import("processing_s3_data_distribution_type.zig").ProcessingS3DataDistributionType;
const ProcessingS3InputMode = @import("processing_s3_input_mode.zig").ProcessingS3InputMode;

/// Input object for the endpoint
pub const EndpointInput = struct {
    /// An endpoint in customer's account which has enabled `DataCaptureConfig`
    /// enabled.
    endpoint_name: []const u8,

    /// If specified, monitoring jobs substract this time from the end time. For
    /// information about using offsets for scheduling monitoring jobs, see
    /// [Schedule Model Quality Monitoring
    /// Jobs](https://docs.aws.amazon.com/sagemaker/latest/dg/model-monitor-model-quality-schedule.html).
    end_time_offset: ?[]const u8,

    /// The attributes of the input data to exclude from the analysis.
    exclude_features_attribute: ?[]const u8,

    /// The attributes of the input data that are the input features.
    features_attribute: ?[]const u8,

    /// The attribute of the input data that represents the ground truth label.
    inference_attribute: ?[]const u8,

    /// Path to the filesystem where the endpoint data is available to the
    /// container.
    local_path: []const u8,

    /// In a classification problem, the attribute that represents the class
    /// probability.
    probability_attribute: ?[]const u8,

    /// The threshold for the class probability to be evaluated as a positive
    /// result.
    probability_threshold_attribute: ?f64,

    /// Whether input data distributed in Amazon S3 is fully replicated or sharded
    /// by an Amazon S3 key. Defaults to `FullyReplicated`
    s3_data_distribution_type: ?ProcessingS3DataDistributionType,

    /// Whether the `Pipe` or `File` is used as the input mode for transferring data
    /// for the monitoring job. `Pipe` mode is recommended for large datasets.
    /// `File` mode is useful for small files that fit in memory. Defaults to
    /// `File`.
    s3_input_mode: ?ProcessingS3InputMode,

    /// If specified, monitoring jobs substract this time from the start time. For
    /// information about using offsets for scheduling monitoring jobs, see
    /// [Schedule Model Quality Monitoring
    /// Jobs](https://docs.aws.amazon.com/sagemaker/latest/dg/model-monitor-model-quality-schedule.html).
    start_time_offset: ?[]const u8,

    pub const json_field_names = .{
        .endpoint_name = "EndpointName",
        .end_time_offset = "EndTimeOffset",
        .exclude_features_attribute = "ExcludeFeaturesAttribute",
        .features_attribute = "FeaturesAttribute",
        .inference_attribute = "InferenceAttribute",
        .local_path = "LocalPath",
        .probability_attribute = "ProbabilityAttribute",
        .probability_threshold_attribute = "ProbabilityThresholdAttribute",
        .s3_data_distribution_type = "S3DataDistributionType",
        .s3_input_mode = "S3InputMode",
        .start_time_offset = "StartTimeOffset",
    };
};
