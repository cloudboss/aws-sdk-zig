const std = @import("std");

pub const ImpactLevel = enum {
    il2,
    il4,
    il5,
    il6,
    il99,

    pub const json_field_names = .{
        .il2 = "IL2",
        .il4 = "IL4",
        .il5 = "IL5",
        .il6 = "IL6",
        .il99 = "IL99",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .il2 => "IL2",
            .il4 => "IL4",
            .il5 => "IL5",
            .il6 => "IL6",
            .il99 => "IL99",
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
