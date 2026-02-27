pub const PipeTargetInvocationType = enum {
    request_response,
    fire_and_forget,

    pub const json_field_names = .{
        .request_response = "REQUEST_RESPONSE",
        .fire_and_forget = "FIRE_AND_FORGET",
    };
};
