const std = @import("std");

pub const TargetGroupProtocolVersion = enum {
    /// Indicates use of HTTP/1.1 to send requests to target
    http1,
    /// Indicates use of HTTP/2 to send requests to target
    http2,
    /// Indicates use of gRPC to send requests to target
    grpc,

    pub const json_field_names = .{
        .http1 = "HTTP1",
        .http2 = "HTTP2",
        .grpc = "GRPC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .http1 => "HTTP1",
            .http2 => "HTTP2",
            .grpc => "GRPC",
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
