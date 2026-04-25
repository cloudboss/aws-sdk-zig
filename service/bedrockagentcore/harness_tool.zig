const HarnessToolConfiguration = @import("harness_tool_configuration.zig").HarnessToolConfiguration;
const HarnessToolType = @import("harness_tool_type.zig").HarnessToolType;

/// A tool available to the agent loop.
pub const HarnessTool = struct {
    /// Tool-specific configuration.
    config: ?HarnessToolConfiguration = null,

    /// Unique name for the tool. If not provided, a name will be inferred or
    /// generated.
    name: ?[]const u8 = null,

    /// The type of tool.
    @"type": HarnessToolType,

    pub const json_field_names = .{
        .config = "config",
        .name = "name",
        .@"type" = "type",
    };
};
