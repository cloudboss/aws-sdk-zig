pub const RDSDBRecommendationFilterName = enum {
    instance_finding,
    instance_finding_reason_code,
    storage_finding,
    storage_finding_reason_code,
    idle,

    pub const json_field_names = .{
        .instance_finding = "INSTANCE_FINDING",
        .instance_finding_reason_code = "INSTANCE_FINDING_REASON_CODE",
        .storage_finding = "STORAGE_FINDING",
        .storage_finding_reason_code = "STORAGE_FINDING_REASON_CODE",
        .idle = "IDLE",
    };
};
