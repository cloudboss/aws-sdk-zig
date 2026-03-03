const std = @import("std");

pub const DeletableCertificateBasedAuthProperty = enum {
    certificate_based_auth_properties_certificate_authority_arn,

    pub const json_field_names = .{
        .certificate_based_auth_properties_certificate_authority_arn = "CERTIFICATE_BASED_AUTH_PROPERTIES_CERTIFICATE_AUTHORITY_ARN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .certificate_based_auth_properties_certificate_authority_arn => "CERTIFICATE_BASED_AUTH_PROPERTIES_CERTIFICATE_AUTHORITY_ARN",
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
