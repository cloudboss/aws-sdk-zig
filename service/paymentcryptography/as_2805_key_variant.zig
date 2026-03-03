const std = @import("std");

pub const As2805KeyVariant = enum {
    terminal_major_key_variant_00,
    pin_encryption_key_variant_28,
    message_authentication_key_variant_24,
    data_encryption_key_variant_22,

    pub const json_field_names = .{
        .terminal_major_key_variant_00 = "TERMINAL_MAJOR_KEY_VARIANT_00",
        .pin_encryption_key_variant_28 = "PIN_ENCRYPTION_KEY_VARIANT_28",
        .message_authentication_key_variant_24 = "MESSAGE_AUTHENTICATION_KEY_VARIANT_24",
        .data_encryption_key_variant_22 = "DATA_ENCRYPTION_KEY_VARIANT_22",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .terminal_major_key_variant_00 => "TERMINAL_MAJOR_KEY_VARIANT_00",
            .pin_encryption_key_variant_28 => "PIN_ENCRYPTION_KEY_VARIANT_28",
            .message_authentication_key_variant_24 => "MESSAGE_AUTHENTICATION_KEY_VARIANT_24",
            .data_encryption_key_variant_22 => "DATA_ENCRYPTION_KEY_VARIANT_22",
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
