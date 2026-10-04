const CodeRepositoryMetadata = @import("code_repository_metadata.zig").CodeRepositoryMetadata;
const ContainerImageMetadata = @import("container_image_metadata.zig").ContainerImageMetadata;
const ContainerRegistryMetadata = @import("container_registry_metadata.zig").ContainerRegistryMetadata;
const ContainerRepositoryMetadata = @import("container_repository_metadata.zig").ContainerRepositoryMetadata;
const Ec2Metadata = @import("ec_2_metadata.zig").Ec2Metadata;
const EcrContainerImageMetadata = @import("ecr_container_image_metadata.zig").EcrContainerImageMetadata;
const EcrRepositoryMetadata = @import("ecr_repository_metadata.zig").EcrRepositoryMetadata;
const LambdaFunctionMetadata = @import("lambda_function_metadata.zig").LambdaFunctionMetadata;
const ServerlessFunctionMetadata = @import("serverless_function_metadata.zig").ServerlessFunctionMetadata;
const VmInstanceMetadata = @import("vm_instance_metadata.zig").VmInstanceMetadata;

/// An object that contains details about the metadata for an Amazon ECR
/// resource.
pub const ResourceScanMetadata = struct {
    /// Contains metadata about scan coverage for a code repository resource.
    code_repository: ?CodeRepositoryMetadata = null,

    /// The container image metadata associated with a covered resource.
    container_image: ?ContainerImageMetadata = null,

    /// The container registry metadata associated with a covered resource.
    container_registry: ?ContainerRegistryMetadata = null,

    /// The container repository metadata associated with a covered resource.
    container_repository: ?ContainerRepositoryMetadata = null,

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

    /// The serverless function metadata associated with a covered resource.
    serverless_function: ?ServerlessFunctionMetadata = null,

    /// The VM instance metadata associated with a covered resource.
    vm_instance: ?VmInstanceMetadata = null,

    pub const json_field_names = .{
        .code_repository = "codeRepository",
        .container_image = "containerImage",
        .container_registry = "containerRegistry",
        .container_repository = "containerRepository",
        .ec_2 = "ec2",
        .ecr_image = "ecrImage",
        .ecr_repository = "ecrRepository",
        .lambda_function = "lambdaFunction",
        .serverless_function = "serverlessFunction",
        .vm_instance = "vmInstance",
    };
};
