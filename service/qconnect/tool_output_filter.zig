const ToolOutputConfiguration = @import("tool_output_configuration.zig").ToolOutputConfiguration;

/// Filter configuration for tool output.
pub const ToolOutputFilter = struct {
    /// The JSON path for filtering tool output.
    json_path: []const u8,

    /// The output configuration for the filter.
    output_configuration: ?ToolOutputConfiguration = null,

    pub const json_field_names = .{
        .json_path = "jsonPath",
        .output_configuration = "outputConfiguration",
    };
};
