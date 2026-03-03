const std = @import("std");

/// Only applies when you set Deinterlace mode to Deinterlace or Adaptive.
/// Interpolate produces sharper pictures, while blend produces smoother motion.
/// If your source file includes a ticker, such as a scrolling headline at the
/// bottom of the frame: Choose Interpolate ticker or Blend ticker. To apply
/// field doubling: Choose Linear interpolation. Note that Linear interpolation
/// may introduce video artifacts into your output.
pub const DeinterlaceAlgorithm = enum {
    interpolate,
    interpolate_ticker,
    blend,
    blend_ticker,
    linear_interpolation,

    pub const json_field_names = .{
        .interpolate = "INTERPOLATE",
        .interpolate_ticker = "INTERPOLATE_TICKER",
        .blend = "BLEND",
        .blend_ticker = "BLEND_TICKER",
        .linear_interpolation = "LINEAR_INTERPOLATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .interpolate => "INTERPOLATE",
            .interpolate_ticker => "INTERPOLATE_TICKER",
            .blend => "BLEND",
            .blend_ticker => "BLEND_TICKER",
            .linear_interpolation => "LINEAR_INTERPOLATION",
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
