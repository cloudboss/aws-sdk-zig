const CachePointBlock = @import("cache_point_block.zig").CachePointBlock;
const SystemTool = @import("system_tool.zig").SystemTool;
const ToolSpecification = @import("tool_specification.zig").ToolSpecification;

/// Information about a tool that you can use with the Converse API. For more
/// information, see [Call a tool with the Converse
/// API](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html) in
/// the Amazon Bedrock User Guide.
pub const Tool = union(enum) {
    /// CachePoint to include in the tool configuration.
    cache_point: ?CachePointBlock,
    /// Specifies the system-defined tool that you want use.
    system_tool: ?SystemTool,
    /// The specfication for the tool.
    tool_spec: ?ToolSpecification,

    pub const json_field_names = .{
        .cache_point = "cachePoint",
        .system_tool = "systemTool",
        .tool_spec = "toolSpec",
    };
};
