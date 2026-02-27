const AccountAggregation = @import("account_aggregation.zig").AccountAggregation;
const AmiAggregation = @import("ami_aggregation.zig").AmiAggregation;
const AwsEcrContainerAggregation = @import("aws_ecr_container_aggregation.zig").AwsEcrContainerAggregation;
const CodeRepositoryAggregation = @import("code_repository_aggregation.zig").CodeRepositoryAggregation;
const Ec2InstanceAggregation = @import("ec_2_instance_aggregation.zig").Ec2InstanceAggregation;
const FindingTypeAggregation = @import("finding_type_aggregation.zig").FindingTypeAggregation;
const ImageLayerAggregation = @import("image_layer_aggregation.zig").ImageLayerAggregation;
const LambdaFunctionAggregation = @import("lambda_function_aggregation.zig").LambdaFunctionAggregation;
const LambdaLayerAggregation = @import("lambda_layer_aggregation.zig").LambdaLayerAggregation;
const PackageAggregation = @import("package_aggregation.zig").PackageAggregation;
const RepositoryAggregation = @import("repository_aggregation.zig").RepositoryAggregation;
const TitleAggregation = @import("title_aggregation.zig").TitleAggregation;

/// Contains details about an aggregation request.
pub const AggregationRequest = union(enum) {
    /// An object that contains details about an aggregation request based on Amazon
    /// Web Services account
    /// IDs.
    account_aggregation: ?AccountAggregation,
    /// An object that contains details about an aggregation request based on Amazon
    /// Machine
    /// Images (AMIs).
    ami_aggregation: ?AmiAggregation,
    /// An object that contains details about an aggregation request based on Amazon
    /// ECR container
    /// images.
    aws_ecr_container_aggregation: ?AwsEcrContainerAggregation,
    /// An object that contains details about an aggregation request based on code
    /// repositories.
    code_repository_aggregation: ?CodeRepositoryAggregation,
    /// An object that contains details about an aggregation request based on Amazon
    /// EC2
    /// instances.
    ec_2_instance_aggregation: ?Ec2InstanceAggregation,
    /// An object that contains details about an aggregation request based on
    /// finding
    /// types.
    finding_type_aggregation: ?FindingTypeAggregation,
    /// An object that contains details about an aggregation request based on
    /// container image
    /// layers.
    image_layer_aggregation: ?ImageLayerAggregation,
    /// Returns an object with findings aggregated by Amazon Web Services Lambda
    /// function.
    lambda_function_aggregation: ?LambdaFunctionAggregation,
    /// Returns an object with findings aggregated by Amazon Web Services Lambda
    /// layer.
    lambda_layer_aggregation: ?LambdaLayerAggregation,
    /// An object that contains details about an aggregation request based on
    /// operating system
    /// package type.
    package_aggregation: ?PackageAggregation,
    /// An object that contains details about an aggregation request based on Amazon
    /// ECR
    /// repositories.
    repository_aggregation: ?RepositoryAggregation,
    /// An object that contains details about an aggregation request based on
    /// finding
    /// title.
    title_aggregation: ?TitleAggregation,

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
