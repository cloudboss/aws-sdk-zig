pub const AggregationType = enum {
    none,
    single_file,

    pub const json_field_names = .{
        .none = "NONE",
        .single_file = "SINGLE_FILE",
    };
};
