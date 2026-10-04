const aws = @import("aws");

const AwsServiceRequestConfiguration = @import("aws_service_request_configuration.zig").AwsServiceRequestConfiguration;
const ConcurrentExecutorConfiguration = @import("concurrent_executor_configuration.zig").ConcurrentExecutorConfiguration;
const CustomOutputConfiguration = @import("custom_output_configuration.zig").CustomOutputConfiguration;
const FunctionType = @import("function_type.zig").FunctionType;
const HttpRequestConfiguration = @import("http_request_configuration.zig").HttpRequestConfiguration;
const SequentialExecutorConfiguration = @import("sequential_executor_configuration.zig").SequentialExecutorConfiguration;
const VastRequestConfiguration = @import("vast_request_configuration.zig").VastRequestConfiguration;

/// Defines reusable logic that MediaTailor executes at lifecycle hooks during
/// ad insertion. The `FunctionType` determines the function's runtime behavior.
/// For more information about functions, see [Working with
/// functions](https://docs.aws.amazon.com/mediatailor/latest/ug/monetization-functions.html) in the *MediaTailor User Guide*.
pub const Function = struct {
    /// The Amazon Resource Name (ARN) of the function.
    arn: ?[]const u8 = null,

    /// The configuration for an `AWS_SERVICE_REQUEST` function. Specifies the
    /// target service, target Region, and request parameters.
    aws_service_request_configuration: ?AwsServiceRequestConfiguration = null,

    /// The configuration for a `CONCURRENT_EXECUTOR` function.
    concurrent_executor_configuration: ?ConcurrentExecutorConfiguration = null,

    /// The configuration for a `CUSTOM_OUTPUT` function.
    custom_output_configuration: ?CustomOutputConfiguration = null,

    /// A description of the function.
    description: ?[]const u8 = null,

    /// The identifier of the function.
    function_id: []const u8,

    /// The type of the function.
    function_type: FunctionType,

    /// The configuration for an `HTTP_REQUEST` function.
    http_request_configuration: ?HttpRequestConfiguration = null,

    /// The configuration for a `SEQUENTIAL_EXECUTOR` function.
    sequential_executor_configuration: ?SequentialExecutorConfiguration = null,

    /// The tags assigned to the function. Tags are key-value pairs that you can
    /// associate with Amazon resources to help with organization, access control,
    /// and cost tracking. For more information, see [Tagging AWS Elemental
    /// MediaTailor
    /// Resources](https://docs.aws.amazon.com/mediatailor/latest/ug/tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The configuration for a `VAST_REQUEST` function.
    vast_request_configuration: ?VastRequestConfiguration = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .aws_service_request_configuration = "AwsServiceRequestConfiguration",
        .concurrent_executor_configuration = "ConcurrentExecutorConfiguration",
        .custom_output_configuration = "CustomOutputConfiguration",
        .description = "Description",
        .function_id = "FunctionId",
        .function_type = "FunctionType",
        .http_request_configuration = "HttpRequestConfiguration",
        .sequential_executor_configuration = "SequentialExecutorConfiguration",
        .tags = "Tags",
        .vast_request_configuration = "VastRequestConfiguration",
    };
};
