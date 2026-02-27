pub const LambdaFunctionRecommendationFilterName = enum {
    finding,
    finding_reason_code,

    pub const json_field_names = .{
        .finding = "FINDING",
        .finding_reason_code = "FINDING_REASON_CODE",
    };
};
