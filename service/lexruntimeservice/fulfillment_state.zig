pub const FulfillmentState = enum {
    fulfilled,
    failed,
    ready_for_fulfillment,

    pub const json_field_names = .{
        .fulfilled = "FULFILLED",
        .failed = "FAILED",
        .ready_for_fulfillment = "READY_FOR_FULFILLMENT",
    };
};
