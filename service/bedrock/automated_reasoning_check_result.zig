const std = @import("std");

pub const AutomatedReasoningCheckResult = enum {
    valid,
    invalid,
    satisfiable,
    impossible,
    translation_ambiguous,
    too_complex,
    no_translation,

    pub const json_field_names = .{
        .valid = "VALID",
        .invalid = "INVALID",
        .satisfiable = "SATISFIABLE",
        .impossible = "IMPOSSIBLE",
        .translation_ambiguous = "TRANSLATION_AMBIGUOUS",
        .too_complex = "TOO_COMPLEX",
        .no_translation = "NO_TRANSLATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .valid => "VALID",
            .invalid => "INVALID",
            .satisfiable => "SATISFIABLE",
            .impossible => "IMPOSSIBLE",
            .translation_ambiguous => "TRANSLATION_AMBIGUOUS",
            .too_complex => "TOO_COMPLEX",
            .no_translation => "NO_TRANSLATION",
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
