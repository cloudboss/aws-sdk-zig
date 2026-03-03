const AutoMLChannelType = @import("auto_ml_channel_type.zig").AutoMLChannelType;
const CompressionType = @import("compression_type.zig").CompressionType;
const AutoMLDataSource = @import("auto_ml_data_source.zig").AutoMLDataSource;

/// A channel is a named input source that training algorithms can consume. This
/// channel is used for AutoML jobs V2 (jobs created by calling
/// [CreateAutoMLJobV2](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateAutoMLJobV2.html)).
pub const AutoMLJobChannel = struct {
    /// The type of channel. Defines whether the data are used for training or
    /// validation. The default value is `training`. Channels for `training` and
    /// `validation` must share the same `ContentType`
    ///
    /// The type of channel defaults to `training` for the time-series forecasting
    /// problem type.
    channel_type: ?AutoMLChannelType = null,

    /// The allowed compression types depend on the input format and problem type.
    /// We allow the compression type `Gzip` for `S3Prefix` inputs on tabular data
    /// only. For all other inputs, the compression type should be `None`. If no
    /// compression type is provided, we default to `None`.
    compression_type: ?CompressionType = null,

    /// The content type of the data from the input source. The following are the
    /// allowed content types for different problems:
    ///
    /// * For tabular problem types: `text/csv;header=present` or
    ///   `x-application/vnd.amazon+parquet`. The default value is
    ///   `text/csv;header=present`.
    /// * For image classification: `image/png`, `image/jpeg`, or `image/*`. The
    ///   default value is `image/*`.
    /// * For text classification: `text/csv;header=present` or
    ///   `x-application/vnd.amazon+parquet`. The default value is
    ///   `text/csv;header=present`.
    /// * For time-series forecasting: `text/csv;header=present` or
    ///   `x-application/vnd.amazon+parquet`. The default value is
    ///   `text/csv;header=present`.
    /// * For text generation (LLMs fine-tuning): `text/csv;header=present` or
    ///   `x-application/vnd.amazon+parquet`. The default value is
    ///   `text/csv;header=present`.
    content_type: ?[]const u8 = null,

    /// The data source for an AutoML channel (Required).
    data_source: ?AutoMLDataSource = null,

    pub const json_field_names = .{
        .channel_type = "ChannelType",
        .compression_type = "CompressionType",
        .content_type = "ContentType",
        .data_source = "DataSource",
    };
};
