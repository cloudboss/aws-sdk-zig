const std = @import("std");

pub const CertificateType = enum {
    certificate,
    certificate_with_private_key,

    pub const json_field_names = .{
        .certificate = "CERTIFICATE",
        .certificate_with_private_key = "CERTIFICATE_WITH_PRIVATE_KEY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .certificate => "CERTIFICATE",
            .certificate_with_private_key => "CERTIFICATE_WITH_PRIVATE_KEY",
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
