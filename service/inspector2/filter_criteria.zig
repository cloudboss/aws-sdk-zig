const StringFilter = @import("string_filter.zig").StringFilter;
const NumberFilter = @import("number_filter.zig").NumberFilter;
const DateFilter = @import("date_filter.zig").DateFilter;
const PortRangeFilter = @import("port_range_filter.zig").PortRangeFilter;
const MapFilter = @import("map_filter.zig").MapFilter;
const PackageFilter = @import("package_filter.zig").PackageFilter;

/// Details on the criteria used to define the filter.
pub const FilterCriteria = struct {
    /// Details of the Amazon Web Services account IDs used to filter findings.
    aws_account_id: ?[]const StringFilter = null,

    /// Filter criteria for findings based on the project name in a code repository.
    code_repository_project_name: ?[]const StringFilter = null,

    /// Filter criteria for findings based on the repository provider type (such as
    /// GitHub,
    /// GitLab, etc.).
    code_repository_provider_type: ?[]const StringFilter = null,

    /// The name of the detector used to identify a code vulnerability in a Lambda
    /// function used
    /// to filter findings.
    code_vulnerability_detector_name: ?[]const StringFilter = null,

    /// The detector type tag associated with the vulnerability used to filter
    /// findings.
    /// Detector tags group related vulnerabilities by common themes or tactics. For
    /// a list of
    /// available tags by programming language, see [Java
    /// tags](https://docs.aws.amazon.com/codeguru/detector-library/java/tags/), or
    /// [Python
    /// tags](https://docs.aws.amazon.com/codeguru/detector-library/python/tags/).
    code_vulnerability_detector_tags: ?[]const StringFilter = null,

    /// The file path to the file in a Lambda function that contains a code
    /// vulnerability used
    /// to filter findings.
    code_vulnerability_file_path: ?[]const StringFilter = null,

    /// Details of the component IDs used to filter findings.
    component_id: ?[]const StringFilter = null,

    /// Details of the component types used to filter findings.
    component_type: ?[]const StringFilter = null,

    /// Details of the Amazon EC2 instance image IDs used to filter findings.
    ec_2_instance_image_id: ?[]const StringFilter = null,

    /// Details of the Amazon EC2 instance subnet IDs used to filter findings.
    ec_2_instance_subnet_id: ?[]const StringFilter = null,

    /// Details of the Amazon EC2 instance VPC IDs used to filter findings.
    ec_2_instance_vpc_id: ?[]const StringFilter = null,

    /// Details of the Amazon ECR image architecture types used to filter findings.
    ecr_image_architecture: ?[]const StringFilter = null,

    /// Details of the Amazon ECR image hashes used to filter findings.
    ecr_image_hash: ?[]const StringFilter = null,

    /// Filter criteria indicating when details for an Amazon ECR image include when
    /// an
    /// Amazon ECR image is in use.
    ecr_image_in_use_count: ?[]const NumberFilter = null,

    /// Filter criteria indicating when an Amazon ECR image was last used in an
    /// Amazon ECS cluster task or Amazon EKS cluster pod.
    ecr_image_last_in_use_at: ?[]const DateFilter = null,

    /// Details on the Amazon ECR image push date and time used to filter findings.
    ecr_image_pushed_at: ?[]const DateFilter = null,

    /// Details on the Amazon ECR registry used to filter findings.
    ecr_image_registry: ?[]const StringFilter = null,

    /// Details on the name of the Amazon ECR repository used to filter findings.
    ecr_image_repository_name: ?[]const StringFilter = null,

    /// The tags attached to the Amazon ECR container image.
    ecr_image_tags: ?[]const StringFilter = null,

    /// The EPSS score used to filter findings.
    epss_score: ?[]const NumberFilter = null,

    /// Filters the list of Amazon Web Services Lambda findings by the availability
    /// of
    /// exploits.
    exploit_available: ?[]const StringFilter = null,

    /// Details on the finding ARNs used to filter findings.
    finding_arn: ?[]const StringFilter = null,

    /// Details on the finding status types used to filter findings.
    finding_status: ?[]const StringFilter = null,

    /// Details on the finding types used to filter findings.
    finding_type: ?[]const StringFilter = null,

    /// Details on the date and time a finding was first seen used to filter
    /// findings.
    first_observed_at: ?[]const DateFilter = null,

    /// Details on whether a fix is available through a version update. This value
    /// can be
    /// `YES`, `NO`, or `PARTIAL`. A `PARTIAL` fix
    /// means that some, but not all, of the packages identified in the finding have
    /// fixes
    /// available through updated versions.
    fix_available: ?[]const StringFilter = null,

    /// The Amazon Inspector score to filter on.
    inspector_score: ?[]const NumberFilter = null,

    /// Filters the list of Amazon Web Services Lambda functions by execution role.
    lambda_function_execution_role_arn: ?[]const StringFilter = null,

    /// Filters the list of Amazon Web Services Lambda functions by the date and
    /// time that a user
    /// last updated the configuration, in [ISO 8601
    /// format](https://www.iso.org/iso-8601-date-and-time-format.html)
    lambda_function_last_modified_at: ?[]const DateFilter = null,

    /// Filters the list of Amazon Web Services Lambda functions by the function's [
    /// layers](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html). A
    /// Lambda function can have up to five layers.
    lambda_function_layers: ?[]const StringFilter = null,

    /// Filters the list of Amazon Web Services Lambda functions by the name of the
    /// function.
    lambda_function_name: ?[]const StringFilter = null,

    /// Filters the list of Amazon Web Services Lambda functions by the runtime
    /// environment for
    /// the Lambda function.
    lambda_function_runtime: ?[]const StringFilter = null,

    /// Details on the date and time a finding was last seen used to filter
    /// findings.
    last_observed_at: ?[]const DateFilter = null,

    /// Details on network protocol used to filter findings.
    network_protocol: ?[]const StringFilter = null,

    /// Details on the port ranges used to filter findings.
    port_range: ?[]const PortRangeFilter = null,

    /// Details on the related vulnerabilities used to filter findings.
    related_vulnerabilities: ?[]const StringFilter = null,

    /// Details on the resource IDs used to filter findings.
    resource_id: ?[]const StringFilter = null,

    /// Details on the resource tags used to filter findings.
    resource_tags: ?[]const MapFilter = null,

    /// Details on the resource types used to filter findings.
    resource_type: ?[]const StringFilter = null,

    /// Details on the severity used to filter findings.
    severity: ?[]const StringFilter = null,

    /// Details on the finding title used to filter findings.
    title: ?[]const StringFilter = null,

    /// Details on the date and time a finding was last updated at used to filter
    /// findings.
    updated_at: ?[]const DateFilter = null,

    /// Details on the vendor severity used to filter findings.
    vendor_severity: ?[]const StringFilter = null,

    /// Details on the vulnerability ID used to filter findings.
    vulnerability_id: ?[]const StringFilter = null,

    /// Details on the vulnerability type used to filter findings.
    vulnerability_source: ?[]const StringFilter = null,

    /// Details on the vulnerable packages used to filter findings.
    vulnerable_packages: ?[]const PackageFilter = null,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .code_repository_project_name = "codeRepositoryProjectName",
        .code_repository_provider_type = "codeRepositoryProviderType",
        .code_vulnerability_detector_name = "codeVulnerabilityDetectorName",
        .code_vulnerability_detector_tags = "codeVulnerabilityDetectorTags",
        .code_vulnerability_file_path = "codeVulnerabilityFilePath",
        .component_id = "componentId",
        .component_type = "componentType",
        .ec_2_instance_image_id = "ec2InstanceImageId",
        .ec_2_instance_subnet_id = "ec2InstanceSubnetId",
        .ec_2_instance_vpc_id = "ec2InstanceVpcId",
        .ecr_image_architecture = "ecrImageArchitecture",
        .ecr_image_hash = "ecrImageHash",
        .ecr_image_in_use_count = "ecrImageInUseCount",
        .ecr_image_last_in_use_at = "ecrImageLastInUseAt",
        .ecr_image_pushed_at = "ecrImagePushedAt",
        .ecr_image_registry = "ecrImageRegistry",
        .ecr_image_repository_name = "ecrImageRepositoryName",
        .ecr_image_tags = "ecrImageTags",
        .epss_score = "epssScore",
        .exploit_available = "exploitAvailable",
        .finding_arn = "findingArn",
        .finding_status = "findingStatus",
        .finding_type = "findingType",
        .first_observed_at = "firstObservedAt",
        .fix_available = "fixAvailable",
        .inspector_score = "inspectorScore",
        .lambda_function_execution_role_arn = "lambdaFunctionExecutionRoleArn",
        .lambda_function_last_modified_at = "lambdaFunctionLastModifiedAt",
        .lambda_function_layers = "lambdaFunctionLayers",
        .lambda_function_name = "lambdaFunctionName",
        .lambda_function_runtime = "lambdaFunctionRuntime",
        .last_observed_at = "lastObservedAt",
        .network_protocol = "networkProtocol",
        .port_range = "portRange",
        .related_vulnerabilities = "relatedVulnerabilities",
        .resource_id = "resourceId",
        .resource_tags = "resourceTags",
        .resource_type = "resourceType",
        .severity = "severity",
        .title = "title",
        .updated_at = "updatedAt",
        .vendor_severity = "vendorSeverity",
        .vulnerability_id = "vulnerabilityId",
        .vulnerability_source = "vulnerabilitySource",
        .vulnerable_packages = "vulnerablePackages",
    };
};
