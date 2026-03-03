const std = @import("std");

pub const CertificateProviderOperation = enum {
    create_certificate_from_csr,

    pub const json_field_names = .{
        .create_certificate_from_csr = "CreateCertificateFromCsr",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_certificate_from_csr => "CreateCertificateFromCsr",
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
