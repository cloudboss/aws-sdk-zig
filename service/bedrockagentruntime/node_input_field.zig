const FlowNodeInputCategory = @import("flow_node_input_category.zig").FlowNodeInputCategory;
const NodeExecutionContent = @import("node_execution_content.zig").NodeExecutionContent;
const NodeInputExecutionChainItem = @import("node_input_execution_chain_item.zig").NodeInputExecutionChainItem;
const NodeInputSource = @import("node_input_source.zig").NodeInputSource;
const FlowNodeIODataType = @import("flow_node_io_data_type.zig").FlowNodeIODataType;

/// Represents an input field provided to a node during a flow execution.
pub const NodeInputField = struct {
    /// The category of the input field.
    category: ?FlowNodeInputCategory = null,

    /// The content of the input field, which can contain text or structured data.
    content: NodeExecutionContent,

    /// The execution path through nested nodes like iterators and loops.
    execution_chain: ?[]const NodeInputExecutionChainItem = null,

    /// The name of the input field as defined in the node's input schema.
    name: []const u8,

    /// The source node that provides input data to this field.
    source: ?NodeInputSource = null,

    /// The data type of the input field for compatibility validation.
    @"type": ?FlowNodeIODataType = null,

    pub const json_field_names = .{
        .category = "category",
        .content = "content",
        .execution_chain = "executionChain",
        .name = "name",
        .source = "source",
        .@"type" = "type",
    };
};
