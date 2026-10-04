const std = @import("std");

pub const TextTransform = enum {
    capitalize,

    pub const json_field_names = .{
        .capitalize = "CAPITALIZE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .capitalize => "CAPITALIZE",
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
