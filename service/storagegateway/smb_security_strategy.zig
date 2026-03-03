const std = @import("std");

pub const SMBSecurityStrategy = enum {
    client_specified,
    mandatory_signing,
    mandatory_encryption,
    mandatory_encryption_no_aes_128,

    pub const json_field_names = .{
        .client_specified = "ClientSpecified",
        .mandatory_signing = "MandatorySigning",
        .mandatory_encryption = "MandatoryEncryption",
        .mandatory_encryption_no_aes_128 = "MandatoryEncryptionNoAes128",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .client_specified => "ClientSpecified",
            .mandatory_signing => "MandatorySigning",
            .mandatory_encryption => "MandatoryEncryption",
            .mandatory_encryption_no_aes_128 => "MandatoryEncryptionNoAes128",
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
