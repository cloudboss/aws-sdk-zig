const RoutingProfileQueueReference = @import("routing_profile_queue_reference.zig").RoutingProfileQueueReference;

/// Contains information about the queue and channel for manual assignment
/// behaviour can be enabled.
pub const RoutingProfileManualAssignmentQueueConfig = struct {
    queue_reference: RoutingProfileQueueReference,

    pub const json_field_names = .{
        .queue_reference = "QueueReference",
    };
};
