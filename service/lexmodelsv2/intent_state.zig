pub const IntentState = enum {
    failed,
    fulfilled,
    in_progress,
    ready_for_fulfillment,
    waiting,
    fulfillment_in_progress,

    pub const json_field_names = .{
        .failed = "Failed",
        .fulfilled = "Fulfilled",
        .in_progress = "InProgress",
        .ready_for_fulfillment = "ReadyForFulfillment",
        .waiting = "Waiting",
        .fulfillment_in_progress = "FulfillmentInProgress",
    };
};
