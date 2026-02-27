const FlowNodeConfiguration = @import("flow_node_configuration.zig").FlowNodeConfiguration;
const FlowNodeInput = @import("flow_node_input.zig").FlowNodeInput;
const FlowNodeOutput = @import("flow_node_output.zig").FlowNodeOutput;
const FlowNodeType = @import("flow_node_type.zig").FlowNodeType;

/// Contains configurations about a node in the flow.
pub const FlowNode = struct {
    /// Contains configurations for the node.
    configuration: ?FlowNodeConfiguration,

    /// An array of objects, each of which contains information about an input into
    /// the node.
    inputs: ?[]const FlowNodeInput,

    /// A name for the node.
    name: []const u8,

    /// A list of objects, each of which contains information about an output from
    /// the node.
    outputs: ?[]const FlowNodeOutput,

    /// The type of node. This value must match the name of the key that you provide
    /// in the configuration you provide in the `FlowNodeConfiguration` field.
    @"type": FlowNodeType,

    pub const json_field_names = .{
        .configuration = "configuration",
        .inputs = "inputs",
        .name = "name",
        .outputs = "outputs",
        .@"type" = "type",
    };
};
