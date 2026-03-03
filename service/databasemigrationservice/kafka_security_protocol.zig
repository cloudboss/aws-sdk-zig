const std = @import("std");

pub const KafkaSecurityProtocol = enum {
    plaintext,
    ssl_authentication,
    ssl_encryption,
    sasl_ssl,

    pub const json_field_names = .{
        .plaintext = "plaintext",
        .ssl_authentication = "ssl-authentication",
        .ssl_encryption = "ssl-encryption",
        .sasl_ssl = "sasl-ssl",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .plaintext => "plaintext",
            .ssl_authentication => "ssl-authentication",
            .ssl_encryption => "ssl-encryption",
            .sasl_ssl => "sasl-ssl",
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
