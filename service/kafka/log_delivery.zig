const ReplicatorLogDelivery = @import("replicator_log_delivery.zig").ReplicatorLogDelivery;

/// Configuration for log delivery to customer destinations.
pub const LogDelivery = struct {
    /// Configuration for replicator log delivery.
    replicator_log_delivery: ?ReplicatorLogDelivery = null,

    pub const json_field_names = .{
        .replicator_log_delivery = "ReplicatorLogDelivery",
    };
};
