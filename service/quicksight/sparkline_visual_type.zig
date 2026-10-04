const std = @import("std");

pub const SparklineVisualType = enum {
    line,
    area_line,

    pub const json_field_names = .{
        .line = "LINE",
        .area_line = "AREA_LINE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .line => "LINE",
            .area_line => "AREA_LINE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
