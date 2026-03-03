const std = @import("std");

pub const TechnicalCueType = enum {
    color_bars,
    end_credits,
    black_frames,
    opening_credits,
    studio_logo,
    slate,
    content,

    pub const json_field_names = .{
        .color_bars = "ColorBars",
        .end_credits = "EndCredits",
        .black_frames = "BlackFrames",
        .opening_credits = "OpeningCredits",
        .studio_logo = "StudioLogo",
        .slate = "Slate",
        .content = "Content",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .color_bars => "ColorBars",
            .end_credits => "EndCredits",
            .black_frames => "BlackFrames",
            .opening_credits => "OpeningCredits",
            .studio_logo => "StudioLogo",
            .slate => "Slate",
            .content => "Content",
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
