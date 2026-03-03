const Architecture = @import("architecture.zig").Architecture;
const PackageType = @import("package_type.zig").PackageType;
const Runtime = @import("runtime.zig").Runtime;
const LambdaVpcConfig = @import("lambda_vpc_config.zig").LambdaVpcConfig;

/// A summary of information about the Amazon Web Services Lambda function.
pub const AwsLambdaFunctionDetails = struct {
    /// The instruction set architecture that the Amazon Web Services Lambda
    /// function supports.
    /// Architecture is a string array with one of the valid values. The default
    /// architecture value
    /// is `x86_64`.
    architectures: ?[]const Architecture = null,

    /// The SHA256 hash of the Amazon Web Services Lambda function's deployment
    /// package.
    code_sha_256: []const u8,

    /// The Amazon Web Services Lambda function's execution role.
    execution_role_arn: []const u8,

    /// The name of the Amazon Web Services Lambda function.
    function_name: []const u8,

    /// The date and time that a user last updated the configuration, in [ISO 8601
    /// format](https://www.iso.org/iso-8601-date-and-time-format.html)
    last_modified_at: ?i64 = null,

    /// The Amazon Web Services Lambda function's [
    /// layers](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html). A
    /// Lambda function can have up to five layers.
    layers: ?[]const []const u8 = null,

    /// The type of deployment package. Set to `Image` for container image and set
    /// `Zip` for .zip file archive.
    package_type: ?PackageType = null,

    /// The runtime environment for the Amazon Web Services Lambda function.
    runtime: Runtime,

    /// The version of the Amazon Web Services Lambda function.
    version: []const u8,

    /// The Amazon Web Services Lambda function's networking configuration.
    vpc_config: ?LambdaVpcConfig = null,

    pub const json_field_names = .{
        .architectures = "architectures",
        .code_sha_256 = "codeSha256",
        .execution_role_arn = "executionRoleArn",
        .function_name = "functionName",
        .last_modified_at = "lastModifiedAt",
        .layers = "layers",
        .package_type = "packageType",
        .runtime = "runtime",
        .version = "version",
        .vpc_config = "vpcConfig",
    };
};
