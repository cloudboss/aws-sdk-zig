const PromptFlowNodeInlineConfiguration = @import("prompt_flow_node_inline_configuration.zig").PromptFlowNodeInlineConfiguration;
const PromptFlowNodeResourceConfiguration = @import("prompt_flow_node_resource_configuration.zig").PromptFlowNodeResourceConfiguration;

/// Contains configurations for a prompt and whether it is from Prompt
/// management or defined inline.
pub const PromptFlowNodeSourceConfiguration = union(enum) {
    /// Contains configurations for a prompt that is defined inline
    @"inline": ?PromptFlowNodeInlineConfiguration,
    /// Contains configurations for a prompt from Prompt management.
    resource: ?PromptFlowNodeResourceConfiguration,

    pub const json_field_names = .{
        .@"inline" = "inline",
        .resource = "resource",
    };
};
