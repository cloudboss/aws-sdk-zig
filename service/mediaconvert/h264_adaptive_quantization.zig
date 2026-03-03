const std = @import("std");

/// Keep the default value, Auto, for this setting to have MediaConvert
/// automatically apply the best types of quantization for your video content.
/// When you want to apply your quantization settings manually, you must set
/// H264AdaptiveQuantization to a value other than Auto. Use this setting to
/// specify the strength of any adaptive quantization filters that you enable.
/// If you don't want MediaConvert to do any adaptive quantization in this
/// transcode, set Adaptive quantization to Off. Related settings: The value
/// that you choose here applies to the following settings:
/// H264FlickerAdaptiveQuantization, H264SpatialAdaptiveQuantization, and
/// H264TemporalAdaptiveQuantization.
pub const H264AdaptiveQuantization = enum {
    off,
    auto,
    low,
    medium,
    high,
    higher,
    max,

    pub const json_field_names = .{
        .off = "OFF",
        .auto = "AUTO",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .higher = "HIGHER",
        .max = "MAX",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .off => "OFF",
            .auto => "AUTO",
            .low => "LOW",
            .medium => "MEDIUM",
            .high => "HIGH",
            .higher => "HIGHER",
            .max => "MAX",
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
