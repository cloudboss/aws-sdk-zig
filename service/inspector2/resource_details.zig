const AwsEc2InstanceDetails = @import("aws_ec_2_instance_details.zig").AwsEc2InstanceDetails;
const AwsEcrContainerImageDetails = @import("aws_ecr_container_image_details.zig").AwsEcrContainerImageDetails;
const AwsLambdaFunctionDetails = @import("aws_lambda_function_details.zig").AwsLambdaFunctionDetails;
const CodeRepositoryDetails = @import("code_repository_details.zig").CodeRepositoryDetails;
const Image = @import("image.zig").Image;
const ServerlessFunction = @import("serverless_function.zig").ServerlessFunction;
const Vm = @import("vm.zig").Vm;

/// Contains details about the resource involved in the finding.
pub const ResourceDetails = struct {
    /// An object that contains details about the Amazon EC2 instance involved in
    /// the finding.
    aws_ec_2_instance: ?AwsEc2InstanceDetails = null,

    /// An object that contains details about the Amazon ECR container image
    /// involved in the
    /// finding.
    aws_ecr_container_image: ?AwsEcrContainerImageDetails = null,

    /// A summary of the information about an Amazon Web Services Lambda function
    /// affected by a
    /// finding.
    aws_lambda_function: ?AwsLambdaFunctionDetails = null,

    /// Contains details about a code repository resource associated with a finding.
    code_repository: ?CodeRepositoryDetails = null,

    /// An object that contains details about a container image involved in the
    /// finding.
    image: ?Image = null,

    /// An object that contains details about a serverless function involved in the
    /// finding.
    serverless_function: ?ServerlessFunction = null,

    /// An object that contains details about a VM instance involved in the finding.
    vm: ?Vm = null,

    pub const json_field_names = .{
        .aws_ec_2_instance = "awsEc2Instance",
        .aws_ecr_container_image = "awsEcrContainerImage",
        .aws_lambda_function = "awsLambdaFunction",
        .code_repository = "codeRepository",
        .image = "image",
        .serverless_function = "serverlessFunction",
        .vm = "vm",
    };
};
