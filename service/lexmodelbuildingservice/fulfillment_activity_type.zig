pub const FulfillmentActivityType = enum {
    return_intent,
    code_hook,

    pub const json_field_names = .{
        .return_intent = "RETURN_INTENT",
        .code_hook = "CODE_HOOK",
    };
};
