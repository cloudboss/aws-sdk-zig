pub const TrainingMetricName = enum {
    hit,
    coverage,
    recall,
    popularity,
    freshness,
    similarity,

    pub const json_field_names = .{
        .hit = "HIT",
        .coverage = "COVERAGE",
        .recall = "RECALL",
        .popularity = "POPULARITY",
        .freshness = "FRESHNESS",
        .similarity = "SIMILARITY",
    };
};
