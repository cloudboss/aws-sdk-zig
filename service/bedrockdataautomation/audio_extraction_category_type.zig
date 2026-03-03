const std = @import("std");

pub const AudioExtractionCategoryType = enum {
    audio_content_moderation,
    transcript,
    topic_content_moderation,

    pub const json_field_names = .{
        .audio_content_moderation = "AUDIO_CONTENT_MODERATION",
        .transcript = "TRANSCRIPT",
        .topic_content_moderation = "TOPIC_CONTENT_MODERATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .audio_content_moderation => "AUDIO_CONTENT_MODERATION",
            .transcript => "TRANSCRIPT",
            .topic_content_moderation => "TOPIC_CONTENT_MODERATION",
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
