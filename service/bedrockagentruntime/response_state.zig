pub const ResponseState = enum {
    failure,
    reprompt,

    pub const json_field_names = .{
        .failure = "FAILURE",
        .reprompt = "REPROMPT",
    };
};
