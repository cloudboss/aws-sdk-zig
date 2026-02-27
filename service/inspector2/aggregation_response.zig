const AccountAggregationResponse = @import("account_aggregation_response.zig").AccountAggregationResponse;
const AmiAggregationResponse = @import("ami_aggregation_response.zig").AmiAggregationResponse;
const AwsEcrContainerAggregationResponse = @import("aws_ecr_container_aggregation_response.zig").AwsEcrContainerAggregationResponse;
const CodeRepositoryAggregationResponse = @import("code_repository_aggregation_response.zig").CodeRepositoryAggregationResponse;
const Ec2InstanceAggregationResponse = @import("ec_2_instance_aggregation_response.zig").Ec2InstanceAggregationResponse;
const FindingTypeAggregationResponse = @import("finding_type_aggregation_response.zig").FindingTypeAggregationResponse;
const ImageLayerAggregationResponse = @import("image_layer_aggregation_response.zig").ImageLayerAggregationResponse;
const LambdaFunctionAggregationResponse = @import("lambda_function_aggregation_response.zig").LambdaFunctionAggregationResponse;
const LambdaLayerAggregationResponse = @import("lambda_layer_aggregation_response.zig").LambdaLayerAggregationResponse;
const PackageAggregationResponse = @import("package_aggregation_response.zig").PackageAggregationResponse;
const RepositoryAggregationResponse = @import("repository_aggregation_response.zig").RepositoryAggregationResponse;
const TitleAggregationResponse = @import("title_aggregation_response.zig").TitleAggregationResponse;

/// A structure that contains details about the results of an aggregation type.
pub const AggregationResponse = union(enum) {
    /// An object that contains details about an aggregation response based on
    /// Amazon Web Services account
    /// IDs.
    account_aggregation: ?AccountAggregationResponse,
    /// An object that contains details about an aggregation response based on
    /// Amazon Machine
    /// Images (AMIs).
    ami_aggregation: ?AmiAggregationResponse,
    /// An object that contains details about an aggregation response based on
    /// Amazon ECR container
    /// images.
    aws_ecr_container_aggregation: ?AwsEcrContainerAggregationResponse,
    /// An object that contains details about an aggregation response based on code
    /// repositories.
    code_repository_aggregation: ?CodeRepositoryAggregationResponse,
    /// An object that contains details about an aggregation response based on
    /// Amazon EC2
    /// instances.
    ec_2_instance_aggregation: ?Ec2InstanceAggregationResponse,
    /// An object that contains details about an aggregation response based on
    /// finding
    /// types.
    finding_type_aggregation: ?FindingTypeAggregationResponse,
    /// An object that contains details about an aggregation response based on
    /// container image
    /// layers.
    image_layer_aggregation: ?ImageLayerAggregationResponse,
    /// An aggregation of findings by Amazon Web Services Lambda function.
    lambda_function_aggregation: ?LambdaFunctionAggregationResponse,
    /// An aggregation of findings by Amazon Web Services Lambda layer.
    lambda_layer_aggregation: ?LambdaLayerAggregationResponse,
    /// An object that contains details about an aggregation response based on
    /// operating system
    /// package type.
    package_aggregation: ?PackageAggregationResponse,
    /// An object that contains details about an aggregation response based on
    /// Amazon ECR
    /// repositories.
    repository_aggregation: ?RepositoryAggregationResponse,
    /// An object that contains details about an aggregation response based on
    /// finding
    /// title.
    title_aggregation: ?TitleAggregationResponse,

    pub const json_field_names = .{
        .account_aggregation = "accountAggregation",
        .ami_aggregation = "amiAggregation",
        .aws_ecr_container_aggregation = "awsEcrContainerAggregation",
        .code_repository_aggregation = "codeRepositoryAggregation",
        .ec_2_instance_aggregation = "ec2InstanceAggregation",
        .finding_type_aggregation = "findingTypeAggregation",
        .image_layer_aggregation = "imageLayerAggregation",
        .lambda_function_aggregation = "lambdaFunctionAggregation",
        .lambda_layer_aggregation = "lambdaLayerAggregation",
        .package_aggregation = "packageAggregation",
        .repository_aggregation = "repositoryAggregation",
        .title_aggregation = "titleAggregation",
    };
};
