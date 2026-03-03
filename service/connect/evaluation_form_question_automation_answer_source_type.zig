const std = @import("std");

pub const EvaluationFormQuestionAutomationAnswerSourceType = enum {
    contact_lens_data,
    gen_ai,

    pub const json_field_names = .{
        .contact_lens_data = "CONTACT_LENS_DATA",
        .gen_ai = "GEN_AI",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .contact_lens_data => "CONTACT_LENS_DATA",
            .gen_ai => "GEN_AI",
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
