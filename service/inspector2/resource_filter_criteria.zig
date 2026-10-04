const ResourceStringFilter = @import("resource_string_filter.zig").ResourceStringFilter;
const ResourceMapFilter = @import("resource_map_filter.zig").ResourceMapFilter;

/// The resource filter criteria for a Software bill of materials (SBOM) report.
pub const ResourceFilterCriteria = struct {
    /// The account IDs used as resource filter criteria.
    account_id: ?[]const ResourceStringFilter = null,

    /// The cloud container image tags used as resource filter criteria.
    cloud_container_image_tags: ?[]const ResourceStringFilter = null,

    /// The cloud container registry names used as resource filter criteria.
    cloud_container_registry_name: ?[]const ResourceStringFilter = null,

    /// The cloud container repository names used as resource filter criteria.
    cloud_container_repository_name: ?[]const ResourceStringFilter = null,

    /// The cloud providers used as resource filter criteria.
    cloud_provider: ?[]const ResourceStringFilter = null,

    /// The cloud provider account IDs used as resource filter criteria.
    cloud_provider_account_id: ?[]const ResourceStringFilter = null,

    /// The cloud provider organization IDs used as resource filter criteria.
    cloud_provider_org_id: ?[]const ResourceStringFilter = null,

    /// The cloud provider regions used as resource filter criteria.
    cloud_provider_region: ?[]const ResourceStringFilter = null,

    /// The cloud serverless function names used as resource filter criteria.
    cloud_serverless_function_name: ?[]const ResourceStringFilter = null,

    /// The cloud serverless function runtimes used as resource filter criteria.
    cloud_serverless_function_runtime: ?[]const ResourceStringFilter = null,

    /// The cloud serverless function tags used as resource filter criteria.
    cloud_serverless_function_tags: ?[]const ResourceMapFilter = null,

    /// The cloud VM instance tags used as resource filter criteria.
    cloud_vm_instance_tags: ?[]const ResourceMapFilter = null,

    /// The EC2 instance tags used as resource filter criteria.
    ec_2_instance_tags: ?[]const ResourceMapFilter = null,

    /// The ECR image tags used as resource filter criteria.
    ecr_image_tags: ?[]const ResourceStringFilter = null,

    /// The ECR repository names used as resource filter criteria.
    ecr_repository_name: ?[]const ResourceStringFilter = null,

    /// The Amazon Web Services Lambda function name used as resource filter
    /// criteria.
    lambda_function_name: ?[]const ResourceStringFilter = null,

    /// The Amazon Web Services Lambda function tags used as resource filter
    /// criteria.
    lambda_function_tags: ?[]const ResourceMapFilter = null,

    /// The resource IDs used as resource filter criteria.
    resource_id: ?[]const ResourceStringFilter = null,

    /// The resource types used as resource filter criteria.
    resource_type: ?[]const ResourceStringFilter = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .cloud_container_image_tags = "cloudContainerImageTags",
        .cloud_container_registry_name = "cloudContainerRegistryName",
        .cloud_container_repository_name = "cloudContainerRepositoryName",
        .cloud_provider = "cloudProvider",
        .cloud_provider_account_id = "cloudProviderAccountId",
        .cloud_provider_org_id = "cloudProviderOrgId",
        .cloud_provider_region = "cloudProviderRegion",
        .cloud_serverless_function_name = "cloudServerlessFunctionName",
        .cloud_serverless_function_runtime = "cloudServerlessFunctionRuntime",
        .cloud_serverless_function_tags = "cloudServerlessFunctionTags",
        .cloud_vm_instance_tags = "cloudVmInstanceTags",
        .ec_2_instance_tags = "ec2InstanceTags",
        .ecr_image_tags = "ecrImageTags",
        .ecr_repository_name = "ecrRepositoryName",
        .lambda_function_name = "lambdaFunctionName",
        .lambda_function_tags = "lambdaFunctionTags",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};
