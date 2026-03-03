const std = @import("std");

pub const NatGatewayApplianceState = enum {
    attaching,
    attached,
    detaching,
    detached,
    attach_failed,
    detach_failed,

    pub const json_field_names = .{
        .attaching = "attaching",
        .attached = "attached",
        .detaching = "detaching",
        .detached = "detached",
        .attach_failed = "attach-failed",
        .detach_failed = "detach-failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .attaching => "attaching",
            .attached => "attached",
            .detaching => "detaching",
            .detached => "detached",
            .attach_failed => "attach-failed",
            .detach_failed => "detach-failed",
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
