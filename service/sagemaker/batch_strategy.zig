pub const BatchStrategy = enum {
    multi_record,
    single_record,

    pub const json_field_names = .{
        .multi_record = "MULTI_RECORD",
        .single_record = "SINGLE_RECORD",
    };
};
