pub const InvokeType = enum {
    request_response,
    event,

    pub const json_field_names = .{
        .request_response = "REQUEST_RESPONSE",
        .event = "EVENT",
    };
};
