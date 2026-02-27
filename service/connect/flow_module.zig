const FlowModuleType = @import("flow_module_type.zig").FlowModuleType;

/// A list of Flow Modules an AI Agent can invoke as a tool
pub const FlowModule = struct {
    /// If of Flow Modules invocable as tool
    flow_module_id: ?[]const u8,

    /// Only Type we support is MCP.
    @"type": ?FlowModuleType,

    pub const json_field_names = .{
        .flow_module_id = "FlowModuleId",
        .@"type" = "Type",
    };
};
