const std = @import("std");

pub const SuggestAdditionalFeature = enum {
    core,
    time_zone,
    phonemes,
    access,
    cross_references,

    pub const json_field_names = .{
        .core = "Core",
        .time_zone = "TimeZone",
        .phonemes = "Phonemes",
        .access = "Access",
        .cross_references = "CrossReferences",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .core => "Core",
            .time_zone => "TimeZone",
            .phonemes => "Phonemes",
            .access => "Access",
            .cross_references => "CrossReferences",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
