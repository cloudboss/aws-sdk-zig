const std = @import("std");

pub const Status = enum {
    move_in_progress,
    in_vpc,
    in_classic,

    pub const json_field_names = .{
        .move_in_progress = "MoveInProgress",
        .in_vpc = "InVpc",
        .in_classic = "InClassic",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .move_in_progress => "MoveInProgress",
            .in_vpc => "InVpc",
            .in_classic => "InClassic",
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
