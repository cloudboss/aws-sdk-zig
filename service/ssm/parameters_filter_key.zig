pub const ParametersFilterKey = enum {
    name,
    type,
    key_id,

    pub const json_field_names = .{
        .name = "NAME",
        .type = "TYPE",
        .key_id = "KEY_ID",
    };
};
