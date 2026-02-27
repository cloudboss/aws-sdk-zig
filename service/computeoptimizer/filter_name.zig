pub const FilterName = enum {
    finding,
    finding_reason_codes,
    recommendation_source_type,
    inferred_workload_types,

    pub const json_field_names = .{
        .finding = "FINDING",
        .finding_reason_codes = "FINDING_REASON_CODES",
        .recommendation_source_type = "RECOMMENDATION_SOURCE_TYPE",
        .inferred_workload_types = "INFERRED_WORKLOAD_TYPES",
    };
};
