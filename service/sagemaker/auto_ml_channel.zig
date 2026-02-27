const AutoMLChannelType = @import("auto_ml_channel_type.zig").AutoMLChannelType;
const CompressionType = @import("compression_type.zig").CompressionType;
const AutoMLDataSource = @import("auto_ml_data_source.zig").AutoMLDataSource;

/// A channel is a named input source that training algorithms can consume. The
/// validation dataset size is limited to less than 2 GB. The training dataset
/// size must be less than 100 GB. For more information, see [
/// Channel](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Channel.html).
///
/// A validation dataset must contain the same headers as the training dataset.
pub const AutoMLChannel = struct {
    /// The channel type (optional) is an `enum` string. The default value is
    /// `training`. Channels for training and validation must share the same
    /// `ContentType` and `TargetAttributeName`. For information on specifying
    /// training and validation channel types, see [How to specify training and
    /// validation
    /// datasets](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-datasets-problem-types.html#autopilot-data-sources-training-or-validation).
    channel_type: ?AutoMLChannelType,

    /// You can use `Gzip` or `None`. The default value is `None`.
    compression_type: ?CompressionType,

    /// The content type of the data from the input source. You can use
    /// `text/csv;header=present` or `x-application/vnd.amazon+parquet`. The default
    /// value is `text/csv;header=present`.
    content_type: ?[]const u8,

    /// The data source for an AutoML channel.
    data_source: ?AutoMLDataSource,

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
    sample_weight_attribute_name: ?[]const u8,

    /// The name of the target variable in supervised learning, usually represented
    /// by 'y'.
    target_attribute_name: []const u8,

    pub const json_field_names = .{
        .channel_type = "ChannelType",
        .compression_type = "CompressionType",
        .content_type = "ContentType",
        .data_source = "DataSource",
        .sample_weight_attribute_name = "SampleWeightAttributeName",
        .target_attribute_name = "TargetAttributeName",
    };
};
