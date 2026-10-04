const std = @import("std");

pub const Architecture = enum {
    arm_64,

    pub const json_field_names = .{
        .arm_64 = "ARM_64",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .arm_64 => "ARM_64",
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
