pub const AnalysisType = enum {
    security,
    code_quality,

    pub const json_field_names = .{
        .security = "SECURITY",
        .code_quality = "CODE_QUALITY",
    };
};
