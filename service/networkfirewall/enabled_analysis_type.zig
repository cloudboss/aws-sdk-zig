const std = @import("std");

pub const EnabledAnalysisType = enum {
    tls_sni,
    http_host,

    pub const json_field_names = .{
        .tls_sni = "TLS_SNI",
        .http_host = "HTTP_HOST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tls_sni => "TLS_SNI",
            .http_host => "HTTP_HOST",
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
