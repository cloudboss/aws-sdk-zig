const std = @import("std");

pub const KeyUsageType = enum {
    sign_verify,
    encrypt_decrypt,
    generate_verify_mac,
    key_agreement,

    pub const json_field_names = .{
        .sign_verify = "SIGN_VERIFY",
        .encrypt_decrypt = "ENCRYPT_DECRYPT",
        .generate_verify_mac = "GENERATE_VERIFY_MAC",
        .key_agreement = "KEY_AGREEMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sign_verify => "SIGN_VERIFY",
            .encrypt_decrypt => "ENCRYPT_DECRYPT",
            .generate_verify_mac => "GENERATE_VERIFY_MAC",
            .key_agreement => "KEY_AGREEMENT",
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
