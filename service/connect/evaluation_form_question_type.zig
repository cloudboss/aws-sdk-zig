const std = @import("std");

pub const EvaluationFormQuestionType = enum {
    text,
    singleselect,
    numeric,
    multiselect,
    datetime,

    pub const json_field_names = .{
        .text = "TEXT",
        .singleselect = "SINGLESELECT",
        .numeric = "NUMERIC",
        .multiselect = "MULTISELECT",
        .datetime = "DATETIME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .text => "TEXT",
            .singleselect => "SINGLESELECT",
            .numeric => "NUMERIC",
            .multiselect => "MULTISELECT",
            .datetime => "DATETIME",
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
