const std = @import("std");

pub const CertificateBasedAuthStatus = enum {
    disabled,
    enabled,
    enabled_no_directory_login_fallback,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
        .enabled_no_directory_login_fallback = "ENABLED_NO_DIRECTORY_LOGIN_FALLBACK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .enabled => "ENABLED",
            .enabled_no_directory_login_fallback => "ENABLED_NO_DIRECTORY_LOGIN_FALLBACK",
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
