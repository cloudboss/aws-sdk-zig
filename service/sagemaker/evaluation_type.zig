const std = @import("std");

pub const EvaluationType = enum {
    llmaj_evaluation,
    custom_scorer_evaluation,
    benchmark_evaluation,

    pub const json_field_names = .{
        .llmaj_evaluation = "LLMAJEvaluation",
        .custom_scorer_evaluation = "CustomScorerEvaluation",
        .benchmark_evaluation = "BenchmarkEvaluation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .llmaj_evaluation => "LLMAJEvaluation",
            .custom_scorer_evaluation => "CustomScorerEvaluation",
            .benchmark_evaluation => "BenchmarkEvaluation",
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
