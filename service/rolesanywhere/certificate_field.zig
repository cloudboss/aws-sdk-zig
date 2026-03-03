const std = @import("std");

pub const CertificateField = enum {
    x_509_subject,
    x_509_issuer,
    x_509_san,

    pub const json_field_names = .{
        .x_509_subject = "x509Subject",
        .x_509_issuer = "x509Issuer",
        .x_509_san = "x509SAN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .x_509_subject => "x509Subject",
            .x_509_issuer => "x509Issuer",
            .x_509_san => "x509SAN",
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
