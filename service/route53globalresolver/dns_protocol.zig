const std = @import("std");

pub const DnsProtocol = enum {
    do53,
    doh,
    dot,

    pub const json_field_names = .{
        .do53 = "DO53",
        .doh = "DOH",
        .dot = "DOT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .do53 => "DO53",
            .doh => "DOH",
            .dot => "DOT",
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
