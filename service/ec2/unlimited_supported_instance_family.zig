const std = @import("std");

pub const UnlimitedSupportedInstanceFamily = enum {
    t_2,
    t_3,
    t_3_a,
    t_4_g,

    pub const json_field_names = .{
        .t_2 = "t2",
        .t_3 = "t3",
        .t_3_a = "t3a",
        .t_4_g = "t4g",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .t_2 => "t2",
            .t_3 => "t3",
            .t_3_a => "t3a",
            .t_4_g => "t4g",
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
