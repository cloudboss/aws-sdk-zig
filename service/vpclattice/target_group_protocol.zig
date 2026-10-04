const std = @import("std");

pub const TargetGroupProtocol = enum {
    /// Indicates HTTP protocol
    http,
    /// Indicates HTTPS protocol
    https,
    /// Indicates TCP protocol
    tcp,

    pub const json_field_names = .{
        .http = "HTTP",
        .https = "HTTPS",
        .tcp = "TCP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .http => "HTTP",
            .https => "HTTPS",
            .tcp => "TCP",
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
