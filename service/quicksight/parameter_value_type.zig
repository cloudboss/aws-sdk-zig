pub const ParameterValueType = enum {
    multi_valued,
    single_valued,

    pub const json_field_names = .{
        .multi_valued = "MULTI_VALUED",
        .single_valued = "SINGLE_VALUED",
    };
};
