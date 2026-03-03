const CoverageStringFilter = @import("coverage_string_filter.zig").CoverageStringFilter;
const CoverageMapFilter = @import("coverage_map_filter.zig").CoverageMapFilter;
const CoverageNumberFilter = @import("coverage_number_filter.zig").CoverageNumberFilter;
const CoverageDateFilter = @import("coverage_date_filter.zig").CoverageDateFilter;

/// A structure that identifies filter criteria for
/// `GetCoverageStatistics`.
pub const CoverageFilterCriteria = struct {
    /// An array of Amazon Web Services account IDs to return coverage statistics
    /// for.
    account_id: ?[]const CoverageStringFilter = null,

    /// Filter criteria for code repositories based on project name.
    code_repository_project_name: ?[]const CoverageStringFilter = null,

    /// Filter criteria for code repositories based on provider type (such as
    /// GitHub, GitLab,
    /// etc.).
    code_repository_provider_type: ?[]const CoverageStringFilter = null,

    /// Filter criteria for code repositories based on visibility setting (public or
    /// private).
    code_repository_provider_type_visibility: ?[]const CoverageStringFilter = null,

    /// The Amazon EC2 instance tags to filter on.
    ec_2_instance_tags: ?[]const CoverageMapFilter = null,

    /// The number of Amazon ECR images in use.
    ecr_image_in_use_count: ?[]const CoverageNumberFilter = null,

    /// The Amazon ECR image that was last in use.
    ecr_image_last_in_use_at: ?[]const CoverageDateFilter = null,

    /// The Amazon ECR image tags to filter on.
    ecr_image_tags: ?[]const CoverageStringFilter = null,

    /// The Amazon ECR repository name to filter on.
    ecr_repository_name: ?[]const CoverageStringFilter = null,

    /// The date an image was last pulled at.
    image_pulled_at: ?[]const CoverageDateFilter = null,

    /// Returns coverage statistics for Amazon Web Services Lambda functions
    /// filtered by function
    /// names.
    lambda_function_name: ?[]const CoverageStringFilter = null,

    /// Returns coverage statistics for Amazon Web Services Lambda functions
    /// filtered by
    /// runtime.
    lambda_function_runtime: ?[]const CoverageStringFilter = null,

    /// Returns coverage statistics for Amazon Web Services Lambda functions
    /// filtered by
    /// tag.
    lambda_function_tags: ?[]const CoverageMapFilter = null,

    /// Filters Amazon Web Services resources based on whether Amazon Inspector has
    /// checked them for vulnerabilities
    /// within the specified time range.
    last_scanned_at: ?[]const CoverageDateFilter = null,

    /// Filter criteria for code repositories based on the ID of the last scanned
    /// commit.
    last_scanned_commit_id: ?[]const CoverageStringFilter = null,

    /// An array of Amazon Web Services resource IDs to return coverage statistics
    /// for.
    resource_id: ?[]const CoverageStringFilter = null,

    /// An array of Amazon Web Services resource types to return coverage statistics
    /// for. The values can be
    /// `AWS_EC2_INSTANCE`, `AWS_LAMBDA_FUNCTION`,
    /// `AWS_ECR_CONTAINER_IMAGE`, `AWS_ECR_REPOSITORY` or
    /// `AWS_ACCOUNT`.
    resource_type: ?[]const CoverageStringFilter = null,

    /// The filter to search for Amazon EC2 instance coverage by scan mode. Valid
    /// values are
    /// `EC2_SSM_AGENT_BASED` and `EC2_AGENTLESS`.
    scan_mode: ?[]const CoverageStringFilter = null,

    /// The scan status code to filter on. Valid values are: `ValidationException`,
    /// `InternalServerException`, `ResourceNotFoundException`,
    /// `BadRequestException`, and `ThrottlingException`.
    scan_status_code: ?[]const CoverageStringFilter = null,

    /// The scan status reason to filter on.
    scan_status_reason: ?[]const CoverageStringFilter = null,

    /// An array of Amazon Inspector scan types to return coverage statistics for.
    scan_type: ?[]const CoverageStringFilter = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .code_repository_project_name = "codeRepositoryProjectName",
        .code_repository_provider_type = "codeRepositoryProviderType",
        .code_repository_provider_type_visibility = "codeRepositoryProviderTypeVisibility",
        .ec_2_instance_tags = "ec2InstanceTags",
        .ecr_image_in_use_count = "ecrImageInUseCount",
        .ecr_image_last_in_use_at = "ecrImageLastInUseAt",
        .ecr_image_tags = "ecrImageTags",
        .ecr_repository_name = "ecrRepositoryName",
        .image_pulled_at = "imagePulledAt",
        .lambda_function_name = "lambdaFunctionName",
        .lambda_function_runtime = "lambdaFunctionRuntime",
        .lambda_function_tags = "lambdaFunctionTags",
        .last_scanned_at = "lastScannedAt",
        .last_scanned_commit_id = "lastScannedCommitId",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
        .scan_mode = "scanMode",
        .scan_status_code = "scanStatusCode",
        .scan_status_reason = "scanStatusReason",
        .scan_type = "scanType",
    };
};
