pub const BatchReportModeType = enum {
    report_individual_builds,
    report_aggregated_batch,

    pub const json_field_names = .{
        .report_individual_builds = "REPORT_INDIVIDUAL_BUILDS",
        .report_aggregated_batch = "REPORT_AGGREGATED_BATCH",
    };
};
