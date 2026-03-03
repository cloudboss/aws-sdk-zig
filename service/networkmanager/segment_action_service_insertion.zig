const std = @import("std");

pub const SegmentActionServiceInsertion = enum {
    send_via,
    send_to,

    pub const json_field_names = .{
        .send_via = "send-via",
        .send_to = "send-to",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .send_via => "send-via",
            .send_to => "send-to",
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
