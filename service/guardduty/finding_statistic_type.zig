pub const FindingStatisticType = enum {
    count_by_severity,

    pub const json_field_names = .{
        .count_by_severity = "COUNT_BY_SEVERITY",
    };
};
