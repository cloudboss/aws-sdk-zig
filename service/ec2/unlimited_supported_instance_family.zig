const std = @import("std");

pub const UnlimitedSupportedInstanceFamily = enum {
    t_2,
    t_3,
    t_3_a,
    t_4_g,
    t_8_i,

    pub const json_field_names = .{
        .t_2 = "t2",
        .t_3 = "t3",
        .t_3_a = "t3a",
        .t_4_g = "t4g",
        .t_8_i = "t8i",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .t_2 => "t2",
            .t_3 => "t3",
            .t_3_a => "t3a",
            .t_4_g => "t4g",
            .t_8_i => "t8i",
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
