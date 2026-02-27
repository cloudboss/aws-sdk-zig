const CachePointBlock = @import("cache_point_block.zig").CachePointBlock;
const ToolSpecification = @import("tool_specification.zig").ToolSpecification;

/// Contains configurations for a tool that a model can use when generating a
/// response. For more information, see [Use a tool to complete an Amazon
/// Bedrock model
/// response](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html).
pub const Tool = union(enum) {
    /// Creates a cache checkpoint within a tool designation
    cache_point: ?CachePointBlock,
    /// The specification for the tool.
    tool_spec: ?ToolSpecification,

    pub const json_field_names = .{
        .cache_point = "cachePoint",
        .tool_spec = "toolSpec",
    };
};
