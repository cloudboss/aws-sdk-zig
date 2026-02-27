pub const PayloadType = enum {
    text,
    return_control,

    pub const json_field_names = .{
        .text = "TEXT",
        .return_control = "RETURN_CONTROL",
    };
};
