pub const LinkDirection = enum {
    response,
    request,

    pub const json_field_names = .{
        .response = "RESPONSE",
        .request = "REQUEST",
    };
};
