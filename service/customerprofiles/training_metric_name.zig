const std = @import("std");

pub const TrainingMetricName = enum {
    hit,
    coverage,
    recall,
    popularity,
    freshness,
    similarity,
    mean_reciprocal_rank_at_25,
    normalized_discounted_cumulative_gain_at_5,
    normalized_discounted_cumulative_gain_at_10,
    normalized_discounted_cumulative_gain_at_25,
    precision_at_5,
    precision_at_10,
    precision_at_25,

    pub const json_field_names = .{
        .hit = "hit",
        .coverage = "coverage",
        .recall = "recall",
        .popularity = "popularity",
        .freshness = "freshness",
        .similarity = "similarity",
        .mean_reciprocal_rank_at_25 = "mean_reciprocal_rank_at_25",
        .normalized_discounted_cumulative_gain_at_5 = "normalized_discounted_cumulative_gain_at_5",
        .normalized_discounted_cumulative_gain_at_10 = "normalized_discounted_cumulative_gain_at_10",
        .normalized_discounted_cumulative_gain_at_25 = "normalized_discounted_cumulative_gain_at_25",
        .precision_at_5 = "precision_at_5",
        .precision_at_10 = "precision_at_10",
        .precision_at_25 = "precision_at_25",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hit => "hit",
            .coverage => "coverage",
            .recall => "recall",
            .popularity => "popularity",
            .freshness => "freshness",
            .similarity => "similarity",
            .mean_reciprocal_rank_at_25 => "mean_reciprocal_rank_at_25",
            .normalized_discounted_cumulative_gain_at_5 => "normalized_discounted_cumulative_gain_at_5",
            .normalized_discounted_cumulative_gain_at_10 => "normalized_discounted_cumulative_gain_at_10",
            .normalized_discounted_cumulative_gain_at_25 => "normalized_discounted_cumulative_gain_at_25",
            .precision_at_5 => "precision_at_5",
            .precision_at_10 => "precision_at_10",
            .precision_at_25 => "precision_at_25",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
