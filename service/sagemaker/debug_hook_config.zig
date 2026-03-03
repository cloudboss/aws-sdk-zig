const aws = @import("aws");

const CollectionConfiguration = @import("collection_configuration.zig").CollectionConfiguration;

/// Configuration information for the Amazon SageMaker Debugger hook parameters,
/// metric and tensor collections, and storage paths. To learn more about how to
/// configure the `DebugHookConfig` parameter, see [Use the SageMaker and
/// Debugger Configuration API Operations to Create, Update, and Debug Your
/// Training
/// Job](https://docs.aws.amazon.com/sagemaker/latest/dg/debugger-createtrainingjob-api.html).
pub const DebugHookConfig = struct {
    /// Configuration information for Amazon SageMaker Debugger tensor collections.
    /// To learn more about how to configure the `CollectionConfiguration`
    /// parameter, see [Use the SageMaker and Debugger Configuration API Operations
    /// to Create, Update, and Debug Your Training
    /// Job](https://docs.aws.amazon.com/sagemaker/latest/dg/debugger-createtrainingjob-api.html).
    collection_configurations: ?[]const CollectionConfiguration = null,

    /// Configuration information for the Amazon SageMaker Debugger hook parameters.
    hook_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Path to local storage location for metrics and tensors. Defaults to
    /// `/opt/ml/output/tensors/`.
    local_path: ?[]const u8 = null,

    /// Path to Amazon S3 storage location for metrics and tensors.
    s3_output_path: []const u8,

    pub const json_field_names = .{
        .collection_configurations = "CollectionConfigurations",
        .hook_parameters = "HookParameters",
        .local_path = "LocalPath",
        .s3_output_path = "S3OutputPath",
    };
};
