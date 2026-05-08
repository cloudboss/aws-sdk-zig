const aws = @import("aws");

const CustomOutputConfiguration = @import("custom_output_configuration.zig").CustomOutputConfiguration;
const FunctionType = @import("function_type.zig").FunctionType;
const HttpRequestConfiguration = @import("http_request_configuration.zig").HttpRequestConfiguration;
const SequentialExecutorConfiguration = @import("sequential_executor_configuration.zig").SequentialExecutorConfiguration;

/// -- Define Mixin --
pub const Function = struct {
    /// The Amazon Resource Name (ARN) of the function.
    arn: ?[]const u8 = null,

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

    pub const json_field_names = .{
        .arn = "Arn",
        .custom_output_configuration = "CustomOutputConfiguration",
        .description = "Description",
        .function_id = "FunctionId",
        .function_type = "FunctionType",
        .http_request_configuration = "HttpRequestConfiguration",
        .sequential_executor_configuration = "SequentialExecutorConfiguration",
        .tags = "Tags",
    };
};
