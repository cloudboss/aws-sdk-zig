pub const AnalysisType = enum {
    security,
    all,

    pub const json_field_names = .{
        .security = "SECURITY",
        .all = "ALL",
    };
};
