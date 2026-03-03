const aws = @import("aws");

const Runtime = @import("runtime.zig").Runtime;

/// The Amazon Web Services Lambda function metadata.
pub const LambdaFunctionMetadata = struct {
    /// The name of a function.
    function_name: ?[]const u8 = null,

    /// The resource tags on an Amazon Web Services Lambda function.
    function_tags: ?[]const aws.map.StringMapEntry = null,

    /// The layers for an Amazon Web Services Lambda function. A Lambda function can
    /// have up to
    /// five layers.
    layers: ?[]const []const u8 = null,

    /// An Amazon Web Services Lambda function's runtime.
    runtime: ?Runtime = null,

    pub const json_field_names = .{
        .function_name = "functionName",
        .function_tags = "functionTags",
        .layers = "layers",
        .runtime = "runtime",
    };
};
