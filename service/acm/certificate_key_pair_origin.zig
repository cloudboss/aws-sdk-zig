const std = @import("std");

/// The origin of the certificate's key pair.
pub const CertificateKeyPairOrigin = enum {
    aws_managed,
    acme,
    customer_provided,

    pub const json_field_names = .{
        .aws_managed = "AWS_MANAGED",
        .acme = "ACME",
        .customer_provided = "CUSTOMER_PROVIDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_managed => "AWS_MANAGED",
            .acme => "ACME",
            .customer_provided => "CUSTOMER_PROVIDED",
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
