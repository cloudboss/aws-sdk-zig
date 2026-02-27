pub const DialogState = enum {
    elicit_intent,
    confirm_intent,
    elicit_slot,
    fulfilled,
    ready_for_fulfillment,
    failed,

    pub const json_field_names = .{
        .elicit_intent = "ELICIT_INTENT",
        .confirm_intent = "CONFIRM_INTENT",
        .elicit_slot = "ELICIT_SLOT",
        .fulfilled = "FULFILLED",
        .ready_for_fulfillment = "READY_FOR_FULFILLMENT",
        .failed = "FAILED",
    };
};
