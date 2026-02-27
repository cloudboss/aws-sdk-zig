pub const Program = enum {
    solution_provider,
    distribution,
    distribution_seller,

    pub const json_field_names = .{
        .solution_provider = "SOLUTION_PROVIDER",
        .distribution = "DISTRIBUTION",
        .distribution_seller = "DISTRIBUTION_SELLER",
    };
};
