const std = @import("std");

/// Fixed Afd
pub const FixedAfd = enum {
    afd_0000,
    afd_0010,
    afd_0011,
    afd_0100,
    afd_1000,
    afd_1001,
    afd_1010,
    afd_1011,
    afd_1101,
    afd_1110,
    afd_1111,

    pub const json_field_names = .{
        .afd_0000 = "AFD_0000",
        .afd_0010 = "AFD_0010",
        .afd_0011 = "AFD_0011",
        .afd_0100 = "AFD_0100",
        .afd_1000 = "AFD_1000",
        .afd_1001 = "AFD_1001",
        .afd_1010 = "AFD_1010",
        .afd_1011 = "AFD_1011",
        .afd_1101 = "AFD_1101",
        .afd_1110 = "AFD_1110",
        .afd_1111 = "AFD_1111",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .afd_0000 => "AFD_0000",
            .afd_0010 => "AFD_0010",
            .afd_0011 => "AFD_0011",
            .afd_0100 => "AFD_0100",
            .afd_1000 => "AFD_1000",
            .afd_1001 => "AFD_1001",
            .afd_1010 => "AFD_1010",
            .afd_1011 => "AFD_1011",
            .afd_1101 => "AFD_1101",
            .afd_1110 => "AFD_1110",
            .afd_1111 => "AFD_1111",
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
