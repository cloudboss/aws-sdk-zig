/// The grouping to sort the results by. Valid values are:
pub const FindingStatisticsSortAttributeName = enum {
    group_key,
    count,

    pub const json_field_names = .{
        .group_key = "groupKey",
        .count = "count",
    };
};
