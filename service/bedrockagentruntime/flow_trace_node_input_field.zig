const FlowNodeInputCategory = @import("flow_node_input_category.zig").FlowNodeInputCategory;
const FlowTraceNodeInputContent = @import("flow_trace_node_input_content.zig").FlowTraceNodeInputContent;
const FlowTraceNodeInputExecutionChainItem = @import("flow_trace_node_input_execution_chain_item.zig").FlowTraceNodeInputExecutionChainItem;
const FlowTraceNodeInputSource = @import("flow_trace_node_input_source.zig").FlowTraceNodeInputSource;
const FlowNodeIODataType = @import("flow_node_io_data_type.zig").FlowNodeIODataType;

/// Contains information about a field in the input into a node. For more
/// information, see [Track each step in your prompt flow by viewing its trace
/// in Amazon
/// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-trace.html).
pub const FlowTraceNodeInputField = struct {
    /// The category of the input field.
    category: ?FlowNodeInputCategory,

    /// The content of the node input.
    content: FlowTraceNodeInputContent,

    /// The execution path through nested nodes like iterators and loops.
    execution_chain: ?[]const FlowTraceNodeInputExecutionChainItem,

    /// The name of the node input.
    node_input_name: []const u8,

    /// The source node that provides input data to this field.
    source: ?FlowTraceNodeInputSource,

    /// The data type of the input field for compatibility validation.
    type: ?FlowNodeIODataType,

    pub const json_field_names = .{
        .category = "category",
        .content = "content",
        .execution_chain = "executionChain",
        .node_input_name = "nodeInputName",
        .source = "source",
        .type = "type",
    };
};
