const std = @import("std");

/// Input resolution based on lines of vertical resolution in the input; SD is
/// less than 720 lines, HD is 720 to 1080 lines, UHD is greater than 1080 lines
pub const InputResolution = enum {
    sd,
    hd,
    uhd,

    pub const json_field_names = .{
        .sd = "SD",
        .hd = "HD",
        .uhd = "UHD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sd => "SD",
            .hd => "HD",
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
