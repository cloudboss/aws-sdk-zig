const std = @import("std");

pub const LiveConnectorMuxType = enum {
    audio_with_composited_video,
    audio_with_active_speaker_video,

    pub const json_field_names = .{
        .audio_with_composited_video = "AudioWithCompositedVideo",
        .audio_with_active_speaker_video = "AudioWithActiveSpeakerVideo",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .audio_with_composited_video => "AudioWithCompositedVideo",
            .audio_with_active_speaker_video => "AudioWithActiveSpeakerVideo",
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
