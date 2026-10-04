const std = @import("std");

pub const AccountVpcEncryptionControlMode = enum {
    unmanaged,
    attempt_monitor,
    attempt_enforce,

    pub const json_field_names = .{
        .unmanaged = "unmanaged",
        .attempt_monitor = "attempt-monitor",
        .attempt_enforce = "attempt-enforce",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unmanaged => "unmanaged",
            .attempt_monitor => "attempt-monitor",
            .attempt_enforce => "attempt-enforce",
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
