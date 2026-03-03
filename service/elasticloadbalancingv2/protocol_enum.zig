const std = @import("std");

pub const ProtocolEnum = enum {
    http,
    https,
    tcp,
    tls,
    udp,
    tcp_udp,
    geneve,
    quic,
    tcp_quic,

    pub const json_field_names = .{
        .http = "HTTP",
        .https = "HTTPS",
        .tcp = "TCP",
        .tls = "TLS",
        .udp = "UDP",
        .tcp_udp = "TCP_UDP",
        .geneve = "GENEVE",
        .quic = "QUIC",
        .tcp_quic = "TCP_QUIC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .http => "HTTP",
            .https => "HTTPS",
            .tcp => "TCP",
            .tls => "TLS",
            .udp => "UDP",
            .tcp_udp => "TCP_UDP",
            .geneve => "GENEVE",
            .quic => "QUIC",
            .tcp_quic => "TCP_QUIC",
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
