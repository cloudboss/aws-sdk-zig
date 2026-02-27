const FlowTraceConditionNodeResultEvent = @import("flow_trace_condition_node_result_event.zig").FlowTraceConditionNodeResultEvent;
const FlowTraceNodeActionEvent = @import("flow_trace_node_action_event.zig").FlowTraceNodeActionEvent;
const FlowTraceDependencyEvent = @import("flow_trace_dependency_event.zig").FlowTraceDependencyEvent;
const FlowTraceNodeInputEvent = @import("flow_trace_node_input_event.zig").FlowTraceNodeInputEvent;
const FlowTraceNodeOutputEvent = @import("flow_trace_node_output_event.zig").FlowTraceNodeOutputEvent;

/// Contains information about an input or output for a node in the flow. For
/// more information, see [Track each step in your prompt flow by viewing its
/// trace in Amazon
/// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-trace.html).
pub const FlowTrace = union(enum) {
    /// Contains information about an output from a condition node.
    condition_node_result_trace: ?FlowTraceConditionNodeResultEvent,
    /// Contains information about an action (operation) called by a node.
    node_action_trace: ?FlowTraceNodeActionEvent,
    /// Contains information about an internal trace of a node.
    node_dependency_trace: ?FlowTraceDependencyEvent,
    /// Contains information about the input into a node.
    node_input_trace: ?FlowTraceNodeInputEvent,
    /// Contains information about the output from a node.
    node_output_trace: ?FlowTraceNodeOutputEvent,

    pub const json_field_names = .{
        .condition_node_result_trace = "conditionNodeResultTrace",
        .node_action_trace = "nodeActionTrace",
        .node_dependency_trace = "nodeDependencyTrace",
        .node_input_trace = "nodeInputTrace",
        .node_output_trace = "nodeOutputTrace",
    };
};
