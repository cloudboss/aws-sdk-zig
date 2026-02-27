pub const DukptKeyVariant = enum {
    bidirectional,
    request,
    response,

    pub const json_field_names = .{
        .bidirectional = "BIDIRECTIONAL",
        .request = "REQUEST",
        .response = "RESPONSE",
    };
};
