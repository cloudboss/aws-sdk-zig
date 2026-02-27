pub const CoverageStatisticsType = enum {
    count_by_resource_type,
    count_by_coverage_status,

    pub const json_field_names = .{
        .count_by_resource_type = "COUNT_BY_RESOURCE_TYPE",
        .count_by_coverage_status = "COUNT_BY_COVERAGE_STATUS",
    };
};
