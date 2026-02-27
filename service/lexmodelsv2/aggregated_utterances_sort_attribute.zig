pub const AggregatedUtterancesSortAttribute = enum {
    hit_count,
    missed_count,

    pub const json_field_names = .{
        .hit_count = "HitCount",
        .missed_count = "MissedCount",
    };
};
