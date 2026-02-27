pub const AnalysisType = enum {
    source_code_analysis,
    database_analysis,
    runtime_analysis,
    binary_analysis,

    pub const json_field_names = .{
        .source_code_analysis = "SOURCE_CODE_ANALYSIS",
        .database_analysis = "DATABASE_ANALYSIS",
        .runtime_analysis = "RUNTIME_ANALYSIS",
        .binary_analysis = "BINARY_ANALYSIS",
    };
};
