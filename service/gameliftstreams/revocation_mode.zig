const std = @import("std");

pub const RevocationMode = enum {
    revoke_url,
    revoke_and_terminate_sessions,

    pub const json_field_names = .{
        .revoke_url = "REVOKE_URL",
        .revoke_and_terminate_sessions = "REVOKE_AND_TERMINATE_SESSIONS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .revoke_url => "REVOKE_URL",
            .revoke_and_terminate_sessions => "REVOKE_AND_TERMINATE_SESSIONS",
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
