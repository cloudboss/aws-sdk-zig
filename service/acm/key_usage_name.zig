const std = @import("std");

pub const KeyUsageName = enum {
    digital_signature,
    non_repudation,
    key_encipherment,
    data_encipherment,
    key_agreement,
    certificate_signing,
    crl_signing,
    enchiper_only,
    decipher_only,
    any,
    custom,

    pub const json_field_names = .{
        .digital_signature = "DIGITAL_SIGNATURE",
        .non_repudation = "NON_REPUDIATION",
        .key_encipherment = "KEY_ENCIPHERMENT",
        .data_encipherment = "DATA_ENCIPHERMENT",
        .key_agreement = "KEY_AGREEMENT",
        .certificate_signing = "CERTIFICATE_SIGNING",
        .crl_signing = "CRL_SIGNING",
        .enchiper_only = "ENCIPHER_ONLY",
        .decipher_only = "DECIPHER_ONLY",
        .any = "ANY",
        .custom = "CUSTOM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .digital_signature => "DIGITAL_SIGNATURE",
            .non_repudation => "NON_REPUDIATION",
            .key_encipherment => "KEY_ENCIPHERMENT",
            .data_encipherment => "DATA_ENCIPHERMENT",
            .key_agreement => "KEY_AGREEMENT",
            .certificate_signing => "CERTIFICATE_SIGNING",
            .crl_signing => "CRL_SIGNING",
            .enchiper_only => "ENCIPHER_ONLY",
            .decipher_only => "DECIPHER_ONLY",
            .any => "ANY",
            .custom => "CUSTOM",
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
