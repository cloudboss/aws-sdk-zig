pub const DialogActionType = enum {
    elicit_intent,
    start_intent,
    elicit_slot,
    evaluate_conditional,
    invoke_dialog_code_hook,
    confirm_intent,
    fulfill_intent,
    close_intent,
    end_conversation,

    pub const json_field_names = .{
        .elicit_intent = "ElicitIntent",
        .start_intent = "StartIntent",
        .elicit_slot = "ElicitSlot",
        .evaluate_conditional = "EvaluateConditional",
        .invoke_dialog_code_hook = "InvokeDialogCodeHook",
        .confirm_intent = "ConfirmIntent",
        .fulfill_intent = "FulfillIntent",
        .close_intent = "CloseIntent",
        .end_conversation = "EndConversation",
    };
};
