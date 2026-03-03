const std = @import("std");

pub const ActivityStreamPolicyStatus = enum {
    locked,
    unlocked,
    locking_policy,
    unlocking_policy,

    pub const json_field_names = .{
        .locked = "locked",
        .unlocked = "unlocked",
        .locking_policy = "locking-policy",
        .unlocking_policy = "unlocking-policy",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .locked => "locked",
            .unlocked => "unlocked",
            .locking_policy => "locking-policy",
            .unlocking_policy => "unlocking-policy",
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
