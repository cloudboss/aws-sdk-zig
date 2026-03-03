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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
