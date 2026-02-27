pub const SelectedAnalysisMethod = enum {
    direct_query,
    direct_job,

    pub const json_field_names = .{
        .direct_query = "DIRECT_QUERY",
        .direct_job = "DIRECT_JOB",
    };
};
