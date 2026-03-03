const std = @import("std");

/// Video Selector Color Space
pub const VideoSelectorColorSpace = enum {
    follow,
    hdr10,
    hlg_2020,
    rec_601,
    rec_709,

    pub const json_field_names = .{
        .follow = "FOLLOW",
        .hdr10 = "HDR10",
        .hlg_2020 = "HLG_2020",
        .rec_601 = "REC_601",
        .rec_709 = "REC_709",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .follow => "FOLLOW",
            .hdr10 => "HDR10",
            .hlg_2020 => "HLG_2020",
            .rec_601 => "REC_601",
            .rec_709 => "REC_709",
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
