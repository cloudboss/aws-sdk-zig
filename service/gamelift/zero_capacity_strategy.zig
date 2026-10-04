const std = @import("std");

pub const ZeroCapacityStrategy = enum {
    manual,
    scale_to_and_from_zero,

    pub const json_field_names = .{
        .manual = "MANUAL",
        .scale_to_and_from_zero = "SCALE_TO_AND_FROM_ZERO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .manual => "MANUAL",
            .scale_to_and_from_zero => "SCALE_TO_AND_FROM_ZERO",
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
