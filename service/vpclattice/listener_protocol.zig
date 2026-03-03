const std = @import("std");

pub const ListenerProtocol = enum {
    /// Indicates HTTP protocol
    http,
    /// Indicates HTTPS protocol
    https,
    /// Indicates TLS_PASSTHROUGH protocol
    tls_passthrough,

    pub const json_field_names = .{
        .http = "HTTP",
        .https = "HTTPS",
        .tls_passthrough = "TLS_PASSTHROUGH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .http => "HTTP",
            .https => "HTTPS",
            .tls_passthrough => "TLS_PASSTHROUGH",
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
