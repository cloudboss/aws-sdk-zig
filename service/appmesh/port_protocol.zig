const std = @import("std");

pub const PortProtocol = enum {
    http,
    tcp,
    http2,
    grpc,

    pub const json_field_names = .{
        .http = "http",
        .tcp = "tcp",
        .http2 = "http2",
        .grpc = "grpc",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .http => "http",
            .tcp => "tcp",
            .http2 => "http2",
            .grpc => "grpc",
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
