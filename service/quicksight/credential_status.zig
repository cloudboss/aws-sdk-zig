const std = @import("std");

pub const CredentialStatus = enum {
    connected,
    auth_failed,
    not_verified,

    pub const json_field_names = .{
        .connected = "CONNECTED",
        .auth_failed = "AUTH_FAILED",
        .not_verified = "NOT_VERIFIED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .connected => "CONNECTED",
            .auth_failed => "AUTH_FAILED",
            .not_verified => "NOT_VERIFIED",
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
