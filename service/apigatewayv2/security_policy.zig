const std = @import("std");

/// The Transport Layer Security (TLS) version of the security policy for this
/// domain name. The valid values are TLS_1_0 and TLS_1_2.
pub const SecurityPolicy = enum {
    tls_1_0,
    tls_1_2,

    pub const json_field_names = .{
        .tls_1_0 = "TLS_1_0",
        .tls_1_2 = "TLS_1_2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tls_1_0 => "TLS_1_0",
            .tls_1_2 => "TLS_1_2",
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
