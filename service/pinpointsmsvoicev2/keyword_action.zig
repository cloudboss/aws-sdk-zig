pub const KeywordAction = enum {
    automatic_response,
    opt_out,
    opt_in,

    pub const json_field_names = .{
        .automatic_response = "AUTOMATIC_RESPONSE",
        .opt_out = "OPT_OUT",
        .opt_in = "OPT_IN",
    };
};
