const ContainerDefinition = @import("container_definition.zig").ContainerDefinition;
const DeploymentRecommendation = @import("deployment_recommendation.zig").DeploymentRecommendation;
const InferenceExecutionConfig = @import("inference_execution_config.zig").InferenceExecutionConfig;
const Tag = @import("tag.zig").Tag;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// The properties of a model as returned by the
/// [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API.
pub const Model = struct {
    /// The containers in the inference pipeline.
    containers: ?[]const ContainerDefinition = null,

    /// A timestamp that indicates when the model was created.
    creation_time: ?i64 = null,

    /// A set of recommended deployment configurations for the model.
    deployment_recommendation: ?DeploymentRecommendation = null,

    /// Isolates the model container. No inbound or outbound network calls can be
    /// made to or from the model container.
    enable_network_isolation: ?bool = null,

    /// The Amazon Resource Name (ARN) of the IAM role that you specified for the
    /// model.
    execution_role_arn: ?[]const u8 = null,

    inference_execution_config: ?InferenceExecutionConfig = null,

    /// The Amazon Resource Name (ARN) of the model.
    model_arn: ?[]const u8 = null,

    /// The name of the model.
    model_name: ?[]const u8 = null,

    primary_container: ?ContainerDefinition = null,

    /// A list of key-value pairs associated with the model. For more information,
    /// see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference Guide*.
    tags: ?[]const Tag = null,

    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .containers = "Containers",
        .creation_time = "CreationTime",
        .deployment_recommendation = "DeploymentRecommendation",
        .enable_network_isolation = "EnableNetworkIsolation",
        .execution_role_arn = "ExecutionRoleArn",
        .inference_execution_config = "InferenceExecutionConfig",
        .model_arn = "ModelArn",
        .model_name = "ModelName",
        .primary_container = "PrimaryContainer",
        .tags = "Tags",
        .vpc_config = "VpcConfig",
    };
};
