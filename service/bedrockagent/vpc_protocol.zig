const std = @import("std");

/// The protocol used to connect to the resource. Valid values:
///
/// * `HTTP` – Connect over plaintext HTTP.
/// * `HTTPS` – Connect over TLS.
pub const VpcProtocol = enum {
    http,
    https,

    pub const json_field_names = .{
        .http = "HTTP",
        .https = "HTTPS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .http => "HTTP",
            .https => "HTTPS",
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
