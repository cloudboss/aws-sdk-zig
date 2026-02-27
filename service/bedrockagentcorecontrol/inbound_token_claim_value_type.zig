pub const InboundTokenClaimValueType = enum {
    string,
    string_array,

    pub const json_field_names = .{
        .string = "STRING",
        .string_array = "STRING_ARRAY",
    };
};
