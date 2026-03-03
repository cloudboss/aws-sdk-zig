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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
