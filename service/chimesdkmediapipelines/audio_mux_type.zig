const std = @import("std");

pub const AudioMuxType = enum {
    audio_only,
    audio_with_active_speaker_video,
    audio_with_composited_video,

    pub const json_field_names = .{
        .audio_only = "AudioOnly",
        .audio_with_active_speaker_video = "AudioWithActiveSpeakerVideo",
        .audio_with_composited_video = "AudioWithCompositedVideo",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .audio_only => "AudioOnly",
            .audio_with_active_speaker_video => "AudioWithActiveSpeakerVideo",
            .audio_with_composited_video => "AudioWithCompositedVideo",
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
