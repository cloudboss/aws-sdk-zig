const std = @import("std");

/// Bandwidth Reduction Filter Strength
pub const BandwidthReductionFilterStrength = enum {
    auto,
    strength_1,
    strength_2,
    strength_3,
    strength_4,

    pub const json_field_names = .{
        .auto = "AUTO",
        .strength_1 = "STRENGTH_1",
        .strength_2 = "STRENGTH_2",
        .strength_3 = "STRENGTH_3",
        .strength_4 = "STRENGTH_4",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .strength_1 => "STRENGTH_1",
            .strength_2 => "STRENGTH_2",
            .strength_3 => "STRENGTH_3",
            .strength_4 => "STRENGTH_4",
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
