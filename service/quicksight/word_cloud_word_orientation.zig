const std = @import("std");

pub const WordCloudWordOrientation = enum {
    horizontal,
    horizontal_and_vertical,

    pub const json_field_names = .{
        .horizontal = "HORIZONTAL",
        .horizontal_and_vertical = "HORIZONTAL_AND_VERTICAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .horizontal => "HORIZONTAL",
            .horizontal_and_vertical => "HORIZONTAL_AND_VERTICAL",
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
