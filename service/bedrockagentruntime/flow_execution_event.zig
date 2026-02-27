const ConditionResultEvent = @import("condition_result_event.zig").ConditionResultEvent;
const FlowFailureEvent = @import("flow_failure_event.zig").FlowFailureEvent;
const FlowExecutionInputEvent = @import("flow_execution_input_event.zig").FlowExecutionInputEvent;
const FlowExecutionOutputEvent = @import("flow_execution_output_event.zig").FlowExecutionOutputEvent;
const NodeActionEvent = @import("node_action_event.zig").NodeActionEvent;
const NodeDependencyEvent = @import("node_dependency_event.zig").NodeDependencyEvent;
const NodeFailureEvent = @import("node_failure_event.zig").NodeFailureEvent;
const NodeInputEvent = @import("node_input_event.zig").NodeInputEvent;
const NodeOutputEvent = @import("node_output_event.zig").NodeOutputEvent;

/// Represents an event that occurred during an flow execution. This is a union
/// type that can contain one of several event types, such as node input and
/// output events; flow input and output events; condition node result events,
/// or failure events.
///
/// Flow executions is in preview release for Amazon Bedrock and is subject to
/// change.
pub const FlowExecutionEvent = union(enum) {
    /// Contains information about a condition evaluation result during the flow
    /// execution. This event is generated when a condition node in the flow
    /// evaluates its conditions.
    condition_result_event: ?ConditionResultEvent,
    /// Contains information about a failure that occurred at the flow level during
    /// execution.
    flow_failure_event: ?FlowFailureEvent,
    /// Contains information about the inputs provided to the flow at the start of
    /// execution.
    flow_input_event: ?FlowExecutionInputEvent,
    /// Contains information about the outputs produced by the flow at the end of
    /// execution.
    flow_output_event: ?FlowExecutionOutputEvent,
    /// Contains information about an action (operation) called by a node during
    /// execution.
    node_action_event: ?NodeActionEvent,
    /// Contains information about an internal trace of a specific node during
    /// execution.
    node_dependency_event: ?NodeDependencyEvent,
    /// Contains information about a failure that occurred at a specific node during
    /// execution.
    node_failure_event: ?NodeFailureEvent,
    /// Contains information about the inputs provided to a specific node during
    /// execution.
    node_input_event: ?NodeInputEvent,
    /// Contains information about the outputs produced by a specific node during
    /// execution.
    node_output_event: ?NodeOutputEvent,

    pub const json_field_names = .{
        .condition_result_event = "conditionResultEvent",
        .flow_failure_event = "flowFailureEvent",
        .flow_input_event = "flowInputEvent",
        .flow_output_event = "flowOutputEvent",
        .node_action_event = "nodeActionEvent",
        .node_dependency_event = "nodeDependencyEvent",
        .node_failure_event = "nodeFailureEvent",
        .node_input_event = "nodeInputEvent",
        .node_output_event = "nodeOutputEvent",
    };
};
