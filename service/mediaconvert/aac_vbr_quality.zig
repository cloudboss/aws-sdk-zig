const std = @import("std");

/// Specify the quality of your variable bitrate (VBR) AAC audio. For a list of
/// approximate VBR bitrates, see:
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/aac-support.html#aac_vbr
pub const AacVbrQuality = enum {
    low,
    medium_low,
    medium_high,
    high,

    pub const json_field_names = .{
        .low = "LOW",
        .medium_low = "MEDIUM_LOW",
        .medium_high = "MEDIUM_HIGH",
        .high = "HIGH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .low => "LOW",
            .medium_low => "MEDIUM_LOW",
            .medium_high => "MEDIUM_HIGH",
            .high => "HIGH",
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
