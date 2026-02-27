pub const DialogActionType = enum {
    close,
    confirm_intent,
    delegate,
    elicit_intent,
    elicit_slot,
    none,

    pub const json_field_names = .{
        .close = "CLOSE",
        .confirm_intent = "CONFIRM_INTENT",
        .delegate = "DELEGATE",
        .elicit_intent = "ELICIT_INTENT",
        .elicit_slot = "ELICIT_SLOT",
        .none = "NONE",
    };
};
