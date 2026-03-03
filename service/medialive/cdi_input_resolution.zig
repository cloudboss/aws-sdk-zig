const std = @import("std");

/// Maximum CDI input resolution; SD is 480i and 576i up to 30 frames-per-second
/// (fps), HD is 720p up to 60 fps / 1080i up to 30 fps, FHD is 1080p up to 60
/// fps, UHD is 2160p up to 60 fps
pub const CdiInputResolution = enum {
    sd,
    hd,
    fhd,
    uhd,

    pub const json_field_names = .{
        .sd = "SD",
        .hd = "HD",
        .fhd = "FHD",
        .uhd = "UHD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sd => "SD",
            .hd => "HD",
            .fhd => "FHD",
            .uhd => "UHD",
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
