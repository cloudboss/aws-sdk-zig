pub const RecommendationType = enum {
    infra_only,
    workload_only,
    all,

    pub const json_field_names = .{
        .infra_only = "INFRA_ONLY",
        .workload_only = "WORKLOAD_ONLY",
        .all = "ALL",
    };
};
