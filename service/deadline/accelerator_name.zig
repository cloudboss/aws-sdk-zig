const std = @import("std");

pub const AcceleratorName = enum {
    t4,
    a10_g,
    l4,
    l40_s,

    pub const json_field_names = .{
        .t4 = "t4",
        .a10_g = "a10g",
        .l4 = "l4",
        .l40_s = "l40s",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .t4 => "t4",
            .a10_g => "a10g",
            .l4 => "l4",
            .l40_s => "l40s",
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
