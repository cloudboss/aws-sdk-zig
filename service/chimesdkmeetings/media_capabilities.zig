const std = @import("std");

pub const MediaCapabilities = enum {
    send_receive,
    send,
    receive,
    none,

    pub const json_field_names = .{
        .send_receive = "SendReceive",
        .send = "Send",
        .receive = "Receive",
        .none = "None",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .send_receive => "SendReceive",
            .send => "Send",
            .receive => "Receive",
            .none => "None",
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
