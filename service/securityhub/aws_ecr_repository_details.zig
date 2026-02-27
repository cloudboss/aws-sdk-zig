const AwsEcrRepositoryImageScanningConfigurationDetails = @import("aws_ecr_repository_image_scanning_configuration_details.zig").AwsEcrRepositoryImageScanningConfigurationDetails;
const AwsEcrRepositoryLifecyclePolicyDetails = @import("aws_ecr_repository_lifecycle_policy_details.zig").AwsEcrRepositoryLifecyclePolicyDetails;

/// Provides information about an Amazon Elastic Container Registry repository.
pub const AwsEcrRepositoryDetails = struct {
    /// The ARN of the repository.
    arn: ?[]const u8,

    /// The image scanning configuration for a repository.
    image_scanning_configuration: ?AwsEcrRepositoryImageScanningConfigurationDetails,

    /// The tag mutability setting for the repository. Valid values are `IMMUTABLE`
    /// or `MUTABLE`.
    image_tag_mutability: ?[]const u8,

    /// Information about the lifecycle policy for the repository.
    lifecycle_policy: ?AwsEcrRepositoryLifecyclePolicyDetails,

    /// The name of the repository.
    repository_name: ?[]const u8,

    /// The text of the repository policy.
    repository_policy_text: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .image_scanning_configuration = "ImageScanningConfiguration",
        .image_tag_mutability = "ImageTagMutability",
        .lifecycle_policy = "LifecyclePolicy",
        .repository_name = "RepositoryName",
        .repository_policy_text = "RepositoryPolicyText",
    };
};
