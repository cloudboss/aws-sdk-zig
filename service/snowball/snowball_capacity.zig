const std = @import("std");

pub const SnowballCapacity = enum {
    t50,
    t80,
    t100,
    t42,
    t98,
    t8,
    t14,
    t32,
    no_preference,
    t240,
    t13,

    pub const json_field_names = .{
        .t50 = "T50",
        .t80 = "T80",
        .t100 = "T100",
        .t42 = "T42",
        .t98 = "T98",
        .t8 = "T8",
        .t14 = "T14",
        .t32 = "T32",
        .no_preference = "NoPreference",
        .t240 = "T240",
        .t13 = "T13",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .t50 => "T50",
            .t80 => "T80",
            .t100 => "T100",
            .t42 => "T42",
            .t98 => "T98",
            .t8 => "T8",
            .t14 => "T14",
            .t32 => "T32",
            .no_preference => "NoPreference",
            .t240 => "T240",
            .t13 => "T13",
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
