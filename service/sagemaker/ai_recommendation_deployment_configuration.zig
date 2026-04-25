const aws = @import("aws");

const AIRecommendationInstanceType = @import("ai_recommendation_instance_type.zig").AIRecommendationInstanceType;
const AIRecommendationDeploymentS3Channel = @import("ai_recommendation_deployment_s3_channel.zig").AIRecommendationDeploymentS3Channel;

/// The deployment configuration for a recommendation.
pub const AIRecommendationDeploymentConfiguration = struct {
    /// The number of model copies per instance.
    copy_count_per_instance: ?i32 = null,

    /// The environment variables for the deployment.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// The URI of the container image for the deployment.
    image_uri: ?[]const u8 = null,

    /// The recommended number of instances for the deployment.
    instance_count: ?i32 = null,

    /// The recommended instance type for the deployment.
    instance_type: ?AIRecommendationInstanceType = null,

    /// The Amazon S3 data channels for the deployment.
    s3: ?[]const AIRecommendationDeploymentS3Channel = null,

    pub const json_field_names = .{
        .copy_count_per_instance = "CopyCountPerInstance",
        .environment_variables = "EnvironmentVariables",
        .image_uri = "ImageUri",
        .instance_count = "InstanceCount",
        .instance_type = "InstanceType",
        .s3 = "S3",
    };
};
