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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
