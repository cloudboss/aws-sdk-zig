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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
