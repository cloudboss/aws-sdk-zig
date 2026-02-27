pub const ComputeEnvironment = enum {
    spark,
    athena,
    python,

    pub const json_field_names = .{
        .spark = "SPARK",
        .athena = "ATHENA",
        .python = "PYTHON",
    };
};
