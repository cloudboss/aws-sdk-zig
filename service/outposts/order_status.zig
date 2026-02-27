pub const OrderStatus = enum {
    received,
    pending,
    processing,
    installing,
    fulfilled,
    cancelled,
    preparing,
    in_progress,
    delivered,
    completed,
    @"error",

    pub const json_field_names = .{
        .received = "RECEIVED",
        .pending = "PENDING",
        .processing = "PROCESSING",
        .installing = "INSTALLING",
        .fulfilled = "FULFILLED",
        .cancelled = "CANCELLED",
        .preparing = "PREPARING",
        .in_progress = "IN_PROGRESS",
        .delivered = "DELIVERED",
        .completed = "COMPLETED",
        .@"error" = "ERROR",
    };
};
