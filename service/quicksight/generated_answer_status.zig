const std = @import("std");

pub const GeneratedAnswerStatus = enum {
    answer_generated,
    answer_retrieved,
    answer_downgrade,

    pub const json_field_names = .{
        .answer_generated = "ANSWER_GENERATED",
        .answer_retrieved = "ANSWER_RETRIEVED",
        .answer_downgrade = "ANSWER_DOWNGRADE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .answer_generated => "ANSWER_GENERATED",
            .answer_retrieved => "ANSWER_RETRIEVED",
            .answer_downgrade => "ANSWER_DOWNGRADE",
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
