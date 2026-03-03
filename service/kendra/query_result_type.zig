const std = @import("std");

pub const QueryResultType = enum {
    document,
    question_answer,
    answer,

    pub const json_field_names = .{
        .document = "DOCUMENT",
        .question_answer = "QUESTION_ANSWER",
        .answer = "ANSWER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .document => "DOCUMENT",
            .question_answer => "QUESTION_ANSWER",
            .answer => "ANSWER",
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
