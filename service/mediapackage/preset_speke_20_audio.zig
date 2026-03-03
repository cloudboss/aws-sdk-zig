const std = @import("std");

pub const PresetSpeke20Audio = enum {
    preset_audio_1,
    preset_audio_2,
    preset_audio_3,
    shared,
    unencrypted,

    pub const json_field_names = .{
        .preset_audio_1 = "PRESET-AUDIO-1",
        .preset_audio_2 = "PRESET-AUDIO-2",
        .preset_audio_3 = "PRESET-AUDIO-3",
        .shared = "SHARED",
        .unencrypted = "UNENCRYPTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .preset_audio_1 => "PRESET-AUDIO-1",
            .preset_audio_2 => "PRESET-AUDIO-2",
            .preset_audio_3 => "PRESET-AUDIO-3",
            .shared => "SHARED",
            .unencrypted => "UNENCRYPTED",
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
