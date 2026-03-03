const std = @import("std");

pub const ParticipantRecordingMediaType = enum {
    audio_video,
    audio_only,
    none,

    pub const json_field_names = .{
        .audio_video = "AUDIO_VIDEO",
        .audio_only = "AUDIO_ONLY",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .audio_video => "AUDIO_VIDEO",
            .audio_only => "AUDIO_ONLY",
            .none => "NONE",
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
