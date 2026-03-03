const std = @import("std");

pub const ApplicationType = enum {
    model_evaluation,
    rag_evaluation,

    pub const json_field_names = .{
        .model_evaluation = "ModelEvaluation",
        .rag_evaluation = "RagEvaluation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .model_evaluation => "ModelEvaluation",
            .rag_evaluation => "RagEvaluation",
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
