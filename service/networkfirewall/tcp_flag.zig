const std = @import("std");

pub const TCPFlag = enum {
    fin,
    syn,
    rst,
    psh,
    ack,
    urg,
    ece,
    cwr,

    pub const json_field_names = .{
        .fin = "FIN",
        .syn = "SYN",
        .rst = "RST",
        .psh = "PSH",
        .ack = "ACK",
        .urg = "URG",
        .ece = "ECE",
        .cwr = "CWR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fin => "FIN",
            .syn => "SYN",
            .rst => "RST",
            .psh => "PSH",
            .ack => "ACK",
            .urg => "URG",
            .ece => "ECE",
            .cwr => "CWR",
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
