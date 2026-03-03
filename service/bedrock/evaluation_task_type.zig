const std = @import("std");

pub const EvaluationTaskType = enum {
    summarization,
    classification,
    question_and_answer,
    generation,
    custom,

    pub const json_field_names = .{
        .summarization = "Summarization",
        .classification = "Classification",
        .question_and_answer = "QuestionAndAnswer",
        .generation = "Generation",
        .custom = "Custom",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .summarization => "Summarization",
            .classification => "Classification",
            .question_and_answer => "QuestionAndAnswer",
            .generation => "Generation",
            .custom => "Custom",
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
