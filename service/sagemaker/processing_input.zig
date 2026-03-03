const DatasetDefinition = @import("dataset_definition.zig").DatasetDefinition;
const ProcessingS3Input = @import("processing_s3_input.zig").ProcessingS3Input;

/// The inputs for a processing job. The processing input must specify exactly
/// one of either `S3Input` or `DatasetDefinition` types.
pub const ProcessingInput = struct {
    /// When `True`, input operations such as data download are managed natively by
    /// the processing job application. When `False` (default), input operations are
    /// managed by Amazon SageMaker.
    app_managed: ?bool = null,

    /// Configuration for a Dataset Definition input.
    dataset_definition: ?DatasetDefinition = null,

    /// The name for the processing job input.
    input_name: []const u8,

    /// Configuration for downloading input data from Amazon S3 into the processing
    /// container.
    s3_input: ?ProcessingS3Input = null,

    pub const json_field_names = .{
        .app_managed = "AppManaged",
        .dataset_definition = "DatasetDefinition",
        .input_name = "InputName",
        .s3_input = "S3Input",
    };
};
