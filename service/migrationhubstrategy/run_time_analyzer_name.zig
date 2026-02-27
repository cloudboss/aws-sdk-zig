pub const RunTimeAnalyzerName = enum {
    a2_c_analyzer,
    rehost_analyzer,
    emp_pa_analyzer,
    database_analyzer,
    sct_analyzer,

    pub const json_field_names = .{
        .a2_c_analyzer = "A2C_ANALYZER",
        .rehost_analyzer = "REHOST_ANALYZER",
        .emp_pa_analyzer = "EMP_PA_ANALYZER",
        .database_analyzer = "DATABASE_ANALYZER",
        .sct_analyzer = "SCT_ANALYZER",
    };
};
