pub const SetStatOption = enum {
    default,
    enable_no_op,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .enable_no_op = "ENABLE_NO_OP",
    };
};
