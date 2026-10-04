const std = @import("std");

pub const VideoExtractionType = enum {
    audio_transcription_only,
    visual_content_and_audio_transcription,

    pub const json_field_names = .{
        .audio_transcription_only = "AUDIO_TRANSCRIPTION_ONLY",
        .visual_content_and_audio_transcription = "VISUAL_CONTENT_AND_AUDIO_TRANSCRIPTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .audio_transcription_only => "AUDIO_TRANSCRIPTION_ONLY",
            .visual_content_and_audio_transcription => "VISUAL_CONTENT_AND_AUDIO_TRANSCRIPTION",
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
