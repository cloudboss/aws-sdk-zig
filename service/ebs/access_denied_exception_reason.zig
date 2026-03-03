const std = @import("std");

pub const AccessDeniedExceptionReason = enum {
    unauthorized_account,
    dependency_access_denied,

    pub const json_field_names = .{
        .unauthorized_account = "UNAUTHORIZED_ACCOUNT",
        .dependency_access_denied = "DEPENDENCY_ACCESS_DENIED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unauthorized_account => "UNAUTHORIZED_ACCOUNT",
            .dependency_access_denied => "DEPENDENCY_ACCESS_DENIED",
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
