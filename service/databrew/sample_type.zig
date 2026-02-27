pub const SampleType = enum {
    first_n,
    last_n,
    random,

    pub const json_field_names = .{
        .first_n = "FIRST_N",
        .last_n = "LAST_N",
        .random = "RANDOM",
    };
};
