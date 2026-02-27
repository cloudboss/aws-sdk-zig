const aws = @import("aws");

const BatchStrategy = @import("batch_strategy.zig").BatchStrategy;
const TransformInput = @import("transform_input.zig").TransformInput;
const TransformOutput = @import("transform_output.zig").TransformOutput;
const TransformResources = @import("transform_resources.zig").TransformResources;

/// Defines the input needed to run a transform job using the inference
/// specification specified in the algorithm.
pub const TransformJobDefinition = struct {
    /// A string that determines the number of records included in a single
    /// mini-batch.
    ///
    /// `SingleRecord` means only one record is used per mini-batch. `MultiRecord`
    /// means a mini-batch is set to contain as many records that can fit within the
    /// `MaxPayloadInMB` limit.
    batch_strategy: ?BatchStrategy,

    /// The environment variables to set in the Docker container. We support up to
    /// 16 key and values entries in the map.
    environment: ?[]const aws.map.StringMapEntry,

    /// The maximum number of parallel requests that can be sent to each instance in
    /// a transform job. The default value is 1.
    max_concurrent_transforms: ?i32,

    /// The maximum payload size allowed, in MB. A payload is the data portion of a
    /// record (without metadata).
    max_payload_in_mb: ?i32,

    /// A description of the input source and the way the transform job consumes it.
    transform_input: TransformInput,

    /// Identifies the Amazon S3 location where you want Amazon SageMaker to save
    /// the results from the transform job.
    transform_output: TransformOutput,

    /// Identifies the ML compute instances for the transform job.
    transform_resources: TransformResources,

    pub const json_field_names = .{
        .batch_strategy = "BatchStrategy",
        .environment = "Environment",
        .max_concurrent_transforms = "MaxConcurrentTransforms",
        .max_payload_in_mb = "MaxPayloadInMB",
        .transform_input = "TransformInput",
        .transform_output = "TransformOutput",
        .transform_resources = "TransformResources",
    };
};
