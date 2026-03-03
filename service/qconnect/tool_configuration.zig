const Annotation = @import("annotation.zig").Annotation;
const ToolInstruction = @import("tool_instruction.zig").ToolInstruction;
const ToolOutputFilter = @import("tool_output_filter.zig").ToolOutputFilter;
const ToolOverrideInputValue = @import("tool_override_input_value.zig").ToolOverrideInputValue;
const ToolType = @import("tool_type.zig").ToolType;
const UserInteractionConfiguration = @import("user_interaction_configuration.zig").UserInteractionConfiguration;

/// Configuration settings for a tool used by AI Agents.
pub const ToolConfiguration = struct {
    /// Annotations for the tool configuration.
    annotations: ?Annotation = null,

    /// The description of the tool configuration.
    description: ?[]const u8 = null,

    /// The input schema for the tool configuration.
    input_schema: ?[]const u8 = null,

    /// Instructions for using the tool.
    instruction: ?ToolInstruction = null,

    /// Output filters applies to the tool result.
    output_filters: ?[]const ToolOutputFilter = null,

    /// The output schema for the tool configuration.
    output_schema: ?[]const u8 = null,

    /// Override input values for the tool configuration.
    override_input_values: ?[]const ToolOverrideInputValue = null,

    /// The title of the tool configuration.
    title: ?[]const u8 = null,

    /// The identifier of the tool, for example toolName from Model Context Provider
    /// server.
    tool_id: ?[]const u8 = null,

    /// The name of the tool.
    tool_name: []const u8,

    /// The type of the tool.
    tool_type: ToolType,

    /// Configuration for user interaction with the tool.
    user_interaction_configuration: ?UserInteractionConfiguration = null,

    pub const json_field_names = .{
        .annotations = "annotations",
        .description = "description",
        .input_schema = "inputSchema",
        .instruction = "instruction",
        .output_filters = "outputFilters",
        .output_schema = "outputSchema",
        .override_input_values = "overrideInputValues",
        .title = "title",
        .tool_id = "toolId",
        .tool_name = "toolName",
        .tool_type = "toolType",
        .user_interaction_configuration = "userInteractionConfiguration",
    };
};
