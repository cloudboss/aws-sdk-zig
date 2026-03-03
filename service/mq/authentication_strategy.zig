const std = @import("std");

/// Optional. The authentication strategy used to secure the broker. The default
/// is SIMPLE.
pub const AuthenticationStrategy = enum {
    simple,
    ldap,
    config_managed,

    pub const json_field_names = .{
        .simple = "SIMPLE",
        .ldap = "LDAP",
        .config_managed = "CONFIG_MANAGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .simple => "SIMPLE",
            .ldap => "LDAP",
            .config_managed => "CONFIG_MANAGED",
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
