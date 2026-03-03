const std = @import("std");

pub const PlaybackInterruptionReason = enum {
    dtmf_start_detected,
    text_detected,
    voice_start_detected,

    pub const json_field_names = .{
        .dtmf_start_detected = "DTMF_START_DETECTED",
        .text_detected = "TEXT_DETECTED",
        .voice_start_detected = "VOICE_START_DETECTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dtmf_start_detected => "DTMF_START_DETECTED",
            .text_detected => "TEXT_DETECTED",
            .voice_start_detected => "VOICE_START_DETECTED",
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
