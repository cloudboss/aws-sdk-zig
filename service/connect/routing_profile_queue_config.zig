const RoutingProfileQueueReference = @import("routing_profile_queue_reference.zig").RoutingProfileQueueReference;

/// Contains information about the queue and channel for which priority and
/// delay can be set.
pub const RoutingProfileQueueConfig = struct {
    /// The delay, in seconds, a contact should be in the queue before they are
    /// routed to an available agent. For more
    /// information, see [Queues: priority and
    /// delay](https://docs.aws.amazon.com/connect/latest/adminguide/concepts-routing-profiles-priority.html) in the *Amazon Connect Administrator Guide*.
    delay: i32,

    /// The order in which contacts are to be handled for the queue. For more
    /// information, see [Queues: priority and
    /// delay](https://docs.aws.amazon.com/connect/latest/adminguide/concepts-routing-profiles-priority.html).
    priority: i32,

    /// Contains information about a queue resource.
    queue_reference: RoutingProfileQueueReference,

    pub const json_field_names = .{
        .delay = "Delay",
        .priority = "Priority",
        .queue_reference = "QueueReference",
    };
};
