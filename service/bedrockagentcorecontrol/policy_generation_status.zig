pub const PolicyGenerationStatus = enum {
    generating,
    generated,
    generate_failed,
    delete_failed,

    pub const json_field_names = .{
        .generating = "GENERATING",
        .generated = "GENERATED",
        .generate_failed = "GENERATE_FAILED",
        .delete_failed = "DELETE_FAILED",
    };
};
