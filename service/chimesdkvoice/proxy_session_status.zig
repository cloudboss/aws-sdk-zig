const std = @import("std");

pub const ProxySessionStatus = enum {
    open,
    in_progress,
    closed,

    pub const json_field_names = .{
        .open = "Open",
        .in_progress = "InProgress",
        .closed = "Closed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .open => "Open",
            .in_progress => "InProgress",
            .closed => "Closed",
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
