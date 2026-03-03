const std = @import("std");

/// Only use this setting when you change the default value, AUTO, for the
/// setting H264AdaptiveQuantization. When you keep all defaults, excluding
/// H264AdaptiveQuantization and all other adaptive quantization from your JSON
/// job specification, MediaConvert automatically applies the best types of
/// quantization for your video content. When you set H264AdaptiveQuantization
/// to a value other than AUTO, the default value for
/// H264FlickerAdaptiveQuantization is Disabled. Change this value to Enabled to
/// reduce I-frame pop. I-frame pop appears as a visual flicker that can arise
/// when the encoder saves bits by copying some macroblocks many times from
/// frame to frame, and then refreshes them at the I-frame. When you enable this
/// setting, the encoder updates these macroblocks slightly more often to smooth
/// out the flicker. To manually enable or disable
/// H264FlickerAdaptiveQuantization, you must set Adaptive quantization to a
/// value other than AUTO.
pub const H264FlickerAdaptiveQuantization = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .enabled => "ENABLED",
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
