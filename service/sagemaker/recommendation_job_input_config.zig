const RecommendationJobContainerConfig = @import("recommendation_job_container_config.zig").RecommendationJobContainerConfig;
const EndpointInputConfiguration = @import("endpoint_input_configuration.zig").EndpointInputConfiguration;
const EndpointInfo = @import("endpoint_info.zig").EndpointInfo;
const RecommendationJobResourceLimit = @import("recommendation_job_resource_limit.zig").RecommendationJobResourceLimit;
const TrafficPattern = @import("traffic_pattern.zig").TrafficPattern;
const RecommendationJobVpcConfig = @import("recommendation_job_vpc_config.zig").RecommendationJobVpcConfig;

/// The input configuration of the recommendation job.
pub const RecommendationJobInputConfig = struct {
    /// Specifies mandatory fields for running an Inference Recommender job. The
    /// fields specified in `ContainerConfig` override the corresponding fields in
    /// the model package.
    container_config: ?RecommendationJobContainerConfig = null,

    /// Specifies the endpoint configuration to use for a job.
    endpoint_configurations: ?[]const EndpointInputConfiguration = null,

    /// Existing customer endpoints on which to run an Inference Recommender job.
    endpoints: ?[]const EndpointInfo = null,

    /// Specifies the maximum duration of the job, in seconds. The maximum value is
    /// 18,000 seconds.
    job_duration_in_seconds: ?i32 = null,

    /// The name of the created model.
    model_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of a versioned model package.
    model_package_version_arn: ?[]const u8 = null,

    /// Defines the resource limit of the job.
    resource_limit: ?RecommendationJobResourceLimit = null,

    /// Specifies the traffic pattern of the job.
    traffic_pattern: ?TrafficPattern = null,

    /// The Amazon Resource Name (ARN) of a Amazon Web Services Key Management
    /// Service (Amazon Web Services KMS) key that Amazon SageMaker uses to encrypt
    /// data on the storage volume attached to the ML compute instance that hosts
    /// the endpoint. This key will be passed to SageMaker Hosting for endpoint
    /// creation.
    ///
    /// The SageMaker execution role must have `kms:CreateGrant` permission in order
    /// to encrypt data on the storage volume of the endpoints created for inference
    /// recommendation. The inference recommendation job will fail asynchronously
    /// during endpoint configuration creation if the role passed does not have
    /// `kms:CreateGrant` permission.
    ///
    /// The `KmsKeyId` can be any of the following formats:
    ///
    /// * // KMS Key ID
    ///
    /// `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    /// * // Amazon Resource Name (ARN) of a KMS Key
    ///
    /// `"arn:aws:kms:<region>:<account>:key/<key-id-12ab-34cd-56ef-1234567890ab>"`
    /// * // KMS Key Alias
    ///
    /// `"alias/ExampleAlias"`
    /// * // Amazon Resource Name (ARN) of a KMS Key Alias
    ///
    /// `"arn:aws:kms:<region>:<account>:alias/<ExampleAlias>"`
    ///
    /// For more information about key identifiers, see [Key identifiers
    /// (KeyID)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-id) in the Amazon Web Services Key Management Service (Amazon Web Services KMS) documentation.
    volume_kms_key_id: ?[]const u8 = null,

    /// Inference Recommender provisions SageMaker endpoints with access to VPC in
    /// the inference recommendation job.
    vpc_config: ?RecommendationJobVpcConfig = null,

    pub const json_field_names = .{
        .container_config = "ContainerConfig",
        .endpoint_configurations = "EndpointConfigurations",
        .endpoints = "Endpoints",
        .job_duration_in_seconds = "JobDurationInSeconds",
        .model_name = "ModelName",
        .model_package_version_arn = "ModelPackageVersionArn",
        .resource_limit = "ResourceLimit",
        .traffic_pattern = "TrafficPattern",
        .volume_kms_key_id = "VolumeKmsKeyId",
        .vpc_config = "VpcConfig",
    };
};
