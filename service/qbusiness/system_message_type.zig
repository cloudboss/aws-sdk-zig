pub const SystemMessageType = enum {
    response,
    grounded_response,

    pub const json_field_names = .{
        .response = "RESPONSE",
        .grounded_response = "GROUNDED_RESPONSE",
    };
};
