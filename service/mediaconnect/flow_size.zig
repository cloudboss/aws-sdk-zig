const std = @import("std");

pub const FlowSize = enum {
    medium,
    large,
    large_4_x,

    pub const json_field_names = .{
        .medium = "MEDIUM",
        .large = "LARGE",
        .large_4_x = "LARGE_4X",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .medium => "MEDIUM",
            .large => "LARGE",
            .large_4_x => "LARGE_4X",
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
