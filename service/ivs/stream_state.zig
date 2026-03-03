const std = @import("std");

pub const StreamState = enum {
    stream_live,
    stream_offline,

    pub const json_field_names = .{
        .stream_live = "LIVE",
        .stream_offline = "OFFLINE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .stream_live => "LIVE",
            .stream_offline => "OFFLINE",
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
