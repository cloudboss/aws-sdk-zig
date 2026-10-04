const std = @import("std");

pub const StreamUrlStatus = enum {
    active,
    expired,
    revoked,
    limit_reached,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .expired = "EXPIRED",
        .revoked = "REVOKED",
        .limit_reached = "LIMIT_REACHED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .expired => "EXPIRED",
            .revoked => "REVOKED",
            .limit_reached => "LIMIT_REACHED",
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
