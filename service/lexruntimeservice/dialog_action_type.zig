pub const DialogActionType = enum {
    elicit_intent,
    confirm_intent,
    elicit_slot,
    close,
    delegate,

    pub const json_field_names = .{
        .elicit_intent = "ELICIT_INTENT",
        .confirm_intent = "CONFIRM_INTENT",
        .elicit_slot = "ELICIT_SLOT",
        .close = "CLOSE",
        .delegate = "DELEGATE",
    };
};
