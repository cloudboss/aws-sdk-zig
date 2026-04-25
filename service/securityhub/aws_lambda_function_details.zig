const AwsLambdaFunctionCode = @import("aws_lambda_function_code.zig").AwsLambdaFunctionCode;
const AwsLambdaFunctionDeadLetterConfig = @import("aws_lambda_function_dead_letter_config.zig").AwsLambdaFunctionDeadLetterConfig;
const AwsLambdaFunctionEnvironment = @import("aws_lambda_function_environment.zig").AwsLambdaFunctionEnvironment;
const AwsLambdaFunctionLayer = @import("aws_lambda_function_layer.zig").AwsLambdaFunctionLayer;
const AwsLambdaFunctionTracingConfig = @import("aws_lambda_function_tracing_config.zig").AwsLambdaFunctionTracingConfig;
const AwsLambdaFunctionVpcConfig = @import("aws_lambda_function_vpc_config.zig").AwsLambdaFunctionVpcConfig;

/// Details about an Lambda function's configuration.
pub const AwsLambdaFunctionDetails = struct {
    /// The instruction set architecture that the function uses. Valid values are
    /// `x86_64` or
    /// `arm64`.
    architectures: ?[]const []const u8 = null,

    /// An `AwsLambdaFunctionCode` object.
    code: ?AwsLambdaFunctionCode = null,

    /// The SHA256 hash of the function's deployment package.
    code_sha_256: ?[]const u8 = null,

    /// The function's dead letter queue.
    dead_letter_config: ?AwsLambdaFunctionDeadLetterConfig = null,

    /// The function's environment variables.
    environment: ?AwsLambdaFunctionEnvironment = null,

    /// The name of the function.
    function_name: ?[]const u8 = null,

    /// The function that Lambda calls to begin executing your function.
    handler: ?[]const u8 = null,

    /// The KMS key that is used to encrypt the function's environment variables.
    /// This key is only returned if you've configured a customer managed customer
    /// managed key.
    kms_key_arn: ?[]const u8 = null,

    /// Indicates when the function was last updated.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    last_modified: ?[]const u8 = null,

    /// The function's layers.
    layers: ?[]const AwsLambdaFunctionLayer = null,

    /// For Lambda@Edge functions, the ARN of the master function.
    master_arn: ?[]const u8 = null,

    /// The memory that is allocated to the function.
    memory_size: ?i32 = null,

    /// The type of deployment package that's used to deploy the function code to
    /// Lambda. Set to `Image` for a container image and `Zip` for a .zip file
    /// archive.
    package_type: ?[]const u8 = null,

    /// The latest updated revision of the function or alias.
    revision_id: ?[]const u8 = null,

    /// The function's execution role.
    role: ?[]const u8 = null,

    /// The runtime environment for the Lambda function.
    runtime: ?[]const u8 = null,

    /// The amount of time that Lambda allows a function to run before stopping it.
    timeout: ?i32 = null,

    /// The function's X-Ray tracing configuration.
    tracing_config: ?AwsLambdaFunctionTracingConfig = null,

    /// The version of the Lambda function.
    version: ?[]const u8 = null,

    /// The function's networking configuration.
    vpc_config: ?AwsLambdaFunctionVpcConfig = null,

    pub const json_field_names = .{
        .architectures = "Architectures",
        .code = "Code",
        .code_sha_256 = "CodeSha256",
        .dead_letter_config = "DeadLetterConfig",
        .environment = "Environment",
        .function_name = "FunctionName",
        .handler = "Handler",
        .kms_key_arn = "KmsKeyArn",
        .last_modified = "LastModified",
        .layers = "Layers",
        .master_arn = "MasterArn",
        .memory_size = "MemorySize",
        .package_type = "PackageType",
        .revision_id = "RevisionId",
        .role = "Role",
        .runtime = "Runtime",
        .timeout = "Timeout",
        .tracing_config = "TracingConfig",
        .version = "Version",
        .vpc_config = "VpcConfig",
    };
};
