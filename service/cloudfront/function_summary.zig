const FunctionConfig = @import("function_config.zig").FunctionConfig;
const FunctionMetadata = @import("function_metadata.zig").FunctionMetadata;

/// Contains configuration information and metadata about a CloudFront function.
pub const FunctionSummary = struct {
    /// Contains configuration information about a CloudFront function.
    function_config: FunctionConfig,

    /// Contains metadata about a CloudFront function.
    function_metadata: FunctionMetadata,

    /// The name of the CloudFront function.
    name: []const u8,

    /// The status of the CloudFront function.
    status: ?[]const u8,
};
