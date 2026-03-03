const std = @import("std");

pub const ThumbnailConfigurationResolution = enum {
    sd,
    hd,
    full_hd,
    lowest_resolution,

    pub const json_field_names = .{
        .sd = "SD",
        .hd = "HD",
        .full_hd = "FULL_HD",
        .lowest_resolution = "LOWEST_RESOLUTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sd => "SD",
            .hd => "HD",
            .full_hd => "FULL_HD",
            .lowest_resolution => "LOWEST_RESOLUTION",
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
