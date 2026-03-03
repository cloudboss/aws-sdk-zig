const std = @import("std");

pub const DocumentThumbnailType = enum {
    small,
    small_hq,
    large,

    pub const json_field_names = .{
        .small = "SMALL",
        .small_hq = "SMALL_HQ",
        .large = "LARGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .small => "SMALL",
            .small_hq => "SMALL_HQ",
            .large => "LARGE",
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
