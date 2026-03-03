const AgentStatusIdentifier = @import("agent_status_identifier.zig").AgentStatusIdentifier;
const Channel = @import("channel.zig").Channel;
const QueueReference = @import("queue_reference.zig").QueueReference;
const RoutingProfileReference = @import("routing_profile_reference.zig").RoutingProfileReference;

/// Contains information about the dimensions for a set of metrics.
pub const Dimensions = struct {
    /// Information about the agent status assigned to the user.
    agent_status: ?AgentStatusIdentifier = null,

    /// The channel used for grouping and filters.
    channel: ?Channel = null,

    /// Information about the queue for which metrics are returned.
    queue: ?QueueReference = null,

    routing_profile: ?RoutingProfileReference = null,

    /// The expression of a step in a routing criteria.
    routing_step_expression: ?[]const u8 = null,

    /// The subtype of the channel used for the contact.
    subtype: ?[]const u8 = null,

    /// The testing and simulation type
    validation_test_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_status = "AgentStatus",
        .channel = "Channel",
        .queue = "Queue",
        .routing_profile = "RoutingProfile",
        .routing_step_expression = "RoutingStepExpression",
        .subtype = "Subtype",
        .validation_test_type = "ValidationTestType",
    };
};
