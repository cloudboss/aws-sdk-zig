pub const AnalysisType = enum {
    direct_analysis,
    additional_analysis,

    pub const json_field_names = .{
        .direct_analysis = "DIRECT_ANALYSIS",
        .additional_analysis = "ADDITIONAL_ANALYSIS",
    };
};
