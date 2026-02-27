pub const BatchJobDependencyType = enum {
    n_to_n,
    sequential,

    pub const json_field_names = .{
        .n_to_n = "N_TO_N",
        .sequential = "SEQUENTIAL",
    };
};
