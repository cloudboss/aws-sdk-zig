const std = @import("std");

pub const CertificateType = enum {
    client_cert_auth,
    client_ldaps,

    pub const json_field_names = .{
        .client_cert_auth = "ClientCertAuth",
        .client_ldaps = "ClientLDAPS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .client_cert_auth => "ClientCertAuth",
            .client_ldaps => "ClientLDAPS",
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
