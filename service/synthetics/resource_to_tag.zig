pub const ResourceToTag = enum {
    lambda_function,

    pub const json_field_names = .{
        .lambda_function = "LAMBDA_FUNCTION",
    };
};
