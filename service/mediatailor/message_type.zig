const std = @import("std");

pub const MessageType = enum {
    splice_insert,
    time_signal,

    pub const json_field_names = .{
        .splice_insert = "SPLICE_INSERT",
        .time_signal = "TIME_SIGNAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .splice_insert => "SPLICE_INSERT",
            .time_signal => "TIME_SIGNAL",
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
