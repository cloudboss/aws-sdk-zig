pub const IntentState = enum {
    failed,
    fulfilled,
    in_progress,
    ready_for_fulfillment,
    waiting,
    fulfillment_in_progress,

    pub const json_field_names = .{
        .failed = "FAILED",
        .fulfilled = "FULFILLED",
        .in_progress = "IN_PROGRESS",
        .ready_for_fulfillment = "READY_FOR_FULFILLMENT",
        .waiting = "WAITING",
        .fulfillment_in_progress = "FULFILLMENT_IN_PROGRESS",
    };
};
