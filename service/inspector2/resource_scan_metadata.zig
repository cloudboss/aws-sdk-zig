const CodeRepositoryMetadata = @import("code_repository_metadata.zig").CodeRepositoryMetadata;
const Ec2Metadata = @import("ec_2_metadata.zig").Ec2Metadata;
const EcrContainerImageMetadata = @import("ecr_container_image_metadata.zig").EcrContainerImageMetadata;
const EcrRepositoryMetadata = @import("ecr_repository_metadata.zig").EcrRepositoryMetadata;
const LambdaFunctionMetadata = @import("lambda_function_metadata.zig").LambdaFunctionMetadata;

/// An object that contains details about the metadata for an Amazon ECR
/// resource.
pub const ResourceScanMetadata = struct {
    /// Contains metadata about scan coverage for a code repository resource.
    code_repository: ?CodeRepositoryMetadata = null,

    /// An object that contains metadata details for an Amazon EC2 instance.
    ec_2: ?Ec2Metadata = null,

    /// An object that contains details about the container metadata for an Amazon
    /// ECR image.
    ecr_image: ?EcrContainerImageMetadata = null,

    /// An object that contains details about the repository an Amazon ECR image
    /// resides in.
    ecr_repository: ?EcrRepositoryMetadata = null,

    /// An object that contains metadata details for an Amazon Web Services Lambda
    /// function.
    lambda_function: ?LambdaFunctionMetadata = null,

    pub const json_field_names = .{
        .code_repository = "codeRepository",
        .ec_2 = "ec2",
        .ecr_image = "ecrImage",
        .ecr_repository = "ecrRepository",
        .lambda_function = "lambdaFunction",
    };
};
