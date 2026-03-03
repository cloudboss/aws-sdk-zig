const std = @import("std");

pub const ProtectConfigurationFilterName = enum {
    account_default,
    deletion_protection_enabled,

    pub const json_field_names = .{
        .account_default = "account-default",
        .deletion_protection_enabled = "deletion-protection-enabled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_default => "account-default",
            .deletion_protection_enabled => "deletion-protection-enabled",
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
