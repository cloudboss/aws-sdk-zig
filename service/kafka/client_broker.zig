const std = @import("std");

/// Client-broker encryption in transit setting.
pub const ClientBroker = enum {
    tls,
    tls_plaintext,
    plaintext,

    pub const json_field_names = .{
        .tls = "TLS",
        .tls_plaintext = "TLS_PLAINTEXT",
        .plaintext = "PLAINTEXT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tls => "TLS",
            .tls_plaintext => "TLS_PLAINTEXT",
            .plaintext => "PLAINTEXT",
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
