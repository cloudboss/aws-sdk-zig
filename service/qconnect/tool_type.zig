pub const ToolType = enum {
    model_context_protocol,
    return_to_control,
    constant,

    pub const json_field_names = .{
        .model_context_protocol = "MODEL_CONTEXT_PROTOCOL",
        .return_to_control = "RETURN_TO_CONTROL",
        .constant = "CONSTANT",
    };
};
