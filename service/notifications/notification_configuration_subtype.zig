const std = @import("std");

pub const NotificationConfigurationSubtype = enum {
    /// Notification configuration created by the account
    account,
    /// Notification configuration managed by an administrator account
    admin_managed,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .admin_managed = "ADMIN_MANAGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account => "ACCOUNT",
            .admin_managed => "ADMIN_MANAGED",
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
