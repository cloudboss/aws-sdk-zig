const std = @import("std");

/// Specify the font that you want the service to use for your burn in captions
/// when your input captions specify a font that MediaConvert doesn't support.
/// When you set Fallback font to best match, or leave blank, MediaConvert uses
/// a supported font that most closely matches the font that your input captions
/// specify. When there are multiple unsupported fonts in your input captions,
/// MediaConvert matches each font with the supported font that matches best.
/// When you explicitly choose a replacement font, MediaConvert uses that font
/// to replace all unsupported fonts from your input.
pub const DvbSubSubtitleFallbackFont = enum {
    best_match,
    monospaced_sansserif,
    monospaced_serif,
    proportional_sansserif,
    proportional_serif,

    pub const json_field_names = .{
        .best_match = "BEST_MATCH",
        .monospaced_sansserif = "MONOSPACED_SANSSERIF",
        .monospaced_serif = "MONOSPACED_SERIF",
        .proportional_sansserif = "PROPORTIONAL_SANSSERIF",
        .proportional_serif = "PROPORTIONAL_SERIF",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .best_match => "BEST_MATCH",
            .monospaced_sansserif => "MONOSPACED_SANSSERIF",
            .monospaced_serif => "MONOSPACED_SERIF",
            .proportional_sansserif => "PROPORTIONAL_SANSSERIF",
            .proportional_serif => "PROPORTIONAL_SERIF",
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
