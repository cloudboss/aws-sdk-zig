pub const AnalysisType = enum {
    max_savings,
    custom_commitment,

    pub const json_field_names = .{
        .max_savings = "MAX_SAVINGS",
        .custom_commitment = "CUSTOM_COMMITMENT",
    };
};
