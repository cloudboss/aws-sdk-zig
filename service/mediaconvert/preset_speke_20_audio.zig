const std = @import("std");

/// Specify which SPEKE version 2.0 audio preset MediaConvert uses to request
/// content keys from your SPEKE server. For more information, see:
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/drm-content-speke-v2-presets.html To encrypt to your audio outputs, choose from the following: Audio preset 1, Audio preset 2, or Audio preset 3. To encrypt your audio outputs, using the same content key for both your audio and video outputs: Choose Shared. When you do, you must also set SPEKE v2.0 video preset to Shared. To not encrypt your audio outputs: Choose Unencrypted. When you do, to encrypt your video outputs, you must also specify a SPEKE v2.0 video preset (other than Shared or Unencrypted).
pub const PresetSpeke20Audio = enum {
    preset_audio_1,
    preset_audio_2,
    preset_audio_3,
    shared,
    unencrypted,

    pub const json_field_names = .{
        .preset_audio_1 = "PRESET_AUDIO_1",
        .preset_audio_2 = "PRESET_AUDIO_2",
        .preset_audio_3 = "PRESET_AUDIO_3",
        .shared = "SHARED",
        .unencrypted = "UNENCRYPTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .preset_audio_1 => "PRESET_AUDIO_1",
            .preset_audio_2 => "PRESET_AUDIO_2",
            .preset_audio_3 => "PRESET_AUDIO_3",
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
