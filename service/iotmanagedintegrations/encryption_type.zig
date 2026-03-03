const std = @import("std");

pub const EncryptionType = enum {
    managed_integrations_default_encryption,
    customer_key_encryption,

    pub const json_field_names = .{
        .managed_integrations_default_encryption = "MANAGED_INTEGRATIONS_DEFAULT_ENCRYPTION",
        .customer_key_encryption = "CUSTOMER_KEY_ENCRYPTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .managed_integrations_default_encryption => "MANAGED_INTEGRATIONS_DEFAULT_ENCRYPTION",
            .customer_key_encryption => "CUSTOMER_KEY_ENCRYPTION",
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
