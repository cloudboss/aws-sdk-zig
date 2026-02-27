pub const GatewayInterceptionPoint = enum {
    request,
    response,

    pub const json_field_names = .{
        .request = "REQUEST",
        .response = "RESPONSE",
    };
};
