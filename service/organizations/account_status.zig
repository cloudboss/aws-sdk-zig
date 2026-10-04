const std = @import("std");

pub const AccountStatus = enum {
    active,
    suspended,
    pending_closure,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .suspended = "SUSPENDED",
        .pending_closure = "PENDING_CLOSURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .suspended => "SUSPENDED",
            .pending_closure => "PENDING_CLOSURE",
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
