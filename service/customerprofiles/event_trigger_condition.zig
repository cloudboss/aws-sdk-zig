const EventTriggerDimension = @import("event_trigger_dimension.zig").EventTriggerDimension;
const EventTriggerLogicalOperator = @import("event_trigger_logical_operator.zig").EventTriggerLogicalOperator;

/// Specifies the circumstances under which the event should trigger the
/// destination.
pub const EventTriggerCondition = struct {
    /// A list of dimensions to be evaluated for the event.
    event_trigger_dimensions: []const EventTriggerDimension,

    /// The operator used to combine multiple dimensions.
    logical_operator: EventTriggerLogicalOperator,

    pub const json_field_names = .{
        .event_trigger_dimensions = "EventTriggerDimensions",
        .logical_operator = "LogicalOperator",
    };
};
