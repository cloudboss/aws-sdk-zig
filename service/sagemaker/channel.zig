const CompressionType = @import("compression_type.zig").CompressionType;
const DataSource = @import("data_source.zig").DataSource;
const TrainingInputMode = @import("training_input_mode.zig").TrainingInputMode;
const RecordWrapper = @import("record_wrapper.zig").RecordWrapper;
const ShuffleConfig = @import("shuffle_config.zig").ShuffleConfig;

/// A channel is a named input source that training algorithms can consume.
pub const Channel = struct {
    /// The name of the channel.
    channel_name: []const u8,

    /// If training data is compressed, the compression type. The default value is
    /// `None`. `CompressionType` is used only in Pipe input mode. In File mode,
    /// leave this field unset or set it to None.
    compression_type: ?CompressionType = null,

    /// The MIME type of the data.
    content_type: ?[]const u8 = null,

    /// The location of the channel data.
    data_source: DataSource,

    /// (Optional) The input mode to use for the data channel in a training job. If
    /// you don't set a value for `InputMode`, SageMaker uses the value set for
    /// `TrainingInputMode`. Use this parameter to override the `TrainingInputMode`
    /// setting in a
    /// [AlgorithmSpecification](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AlgorithmSpecification.html) request when you have a channel that needs a different input mode from the training job's general setting. To download the data from Amazon Simple Storage Service (Amazon S3) to the provisioned ML storage volume, and mount the directory to a Docker volume, use `File` input mode. To stream data directly from Amazon S3 to the container, choose `Pipe` input mode.
    ///
    /// To use a model for incremental training, choose `File` input model.
    input_mode: ?TrainingInputMode = null,

    /// Specify RecordIO as the value when input data is in raw format but the
    /// training algorithm requires the RecordIO format. In this case, SageMaker
    /// wraps each individual S3 object in a RecordIO record. If the input data is
    /// already in RecordIO format, you don't need to set this attribute. For more
    /// information, see [Create a Dataset Using
    /// RecordIO](https://mxnet.apache.org/api/architecture/note_data_loading#data-format).
    ///
    /// In File mode, leave this field unset or set it to None.
    record_wrapper_type: ?RecordWrapper = null,

    /// A configuration for a shuffle option for input data in a channel. If you use
    /// `S3Prefix` for `S3DataType`, this shuffles the results of the S3 key prefix
    /// matches. If you use `ManifestFile`, the order of the S3 object references in
    /// the `ManifestFile` is shuffled. If you use `AugmentedManifestFile`, the
    /// order of the JSON lines in the `AugmentedManifestFile` is shuffled. The
    /// shuffling order is determined using the `Seed` value.
    ///
    /// For Pipe input mode, shuffling is done at the start of every epoch. With
    /// large datasets this ensures that the order of the training data is different
    /// for each epoch, it helps reduce bias and possible overfitting. In a
    /// multi-node training job when ShuffleConfig is combined with
    /// `S3DataDistributionType` of `ShardedByS3Key`, the data is shuffled across
    /// nodes so that the content sent to a particular node on the first epoch might
    /// be sent to a different node on the second epoch.
    shuffle_config: ?ShuffleConfig = null,

    pub const json_field_names = .{
        .channel_name = "ChannelName",
        .compression_type = "CompressionType",
        .content_type = "ContentType",
        .data_source = "DataSource",
        .input_mode = "InputMode",
        .record_wrapper_type = "RecordWrapperType",
        .shuffle_config = "ShuffleConfig",
    };
};
