const std = @import("std");

pub const AudioStandardGenerativeFieldType = enum {
    audio_summary,
    iab,
    topic_summary,

    pub const json_field_names = .{
        .audio_summary = "AUDIO_SUMMARY",
        .iab = "IAB",
        .topic_summary = "TOPIC_SUMMARY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .audio_summary => "AUDIO_SUMMARY",
            .iab => "IAB",
            .topic_summary => "TOPIC_SUMMARY",
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
