const std = @import("std");

pub const TargetHealthStateEnum = enum {
    initial,
    healthy,
    unhealthy,
    unhealthy_draining,
    unused,
    draining,
    unavailable,

    pub const json_field_names = .{
        .initial = "initial",
        .healthy = "healthy",
        .unhealthy = "unhealthy",
        .unhealthy_draining = "unhealthy.draining",
        .unused = "unused",
        .draining = "draining",
        .unavailable = "unavailable",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initial => "initial",
            .healthy => "healthy",
            .unhealthy => "unhealthy",
            .unhealthy_draining => "unhealthy.draining",
            .unused => "unused",
            .draining => "draining",
            .unavailable => "unavailable",
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
