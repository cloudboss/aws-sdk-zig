const std = @import("std");

pub const DeploymentStrategy = enum {
    rolling,
    blue_green,
    linear,
    canary,

    pub const json_field_names = .{
        .rolling = "ROLLING",
        .blue_green = "BLUE_GREEN",
        .linear = "LINEAR",
        .canary = "CANARY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rolling => "ROLLING",
            .blue_green => "BLUE_GREEN",
            .linear => "LINEAR",
            .canary => "CANARY",
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
