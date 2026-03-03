const std = @import("std");

pub const MoveStatus = enum {
    moving_to_vpc,
    restoring_to_classic,

    pub const json_field_names = .{
        .moving_to_vpc = "movingToVpc",
        .restoring_to_classic = "restoringToClassic",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .moving_to_vpc => "movingToVpc",
            .restoring_to_classic => "restoringToClassic",
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
