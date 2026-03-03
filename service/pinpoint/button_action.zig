const std = @import("std");

pub const ButtonAction = enum {
    link,
    deep_link,
    close,

    pub const json_field_names = .{
        .link = "LINK",
        .deep_link = "DEEP_LINK",
        .close = "CLOSE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .link => "LINK",
            .deep_link => "DEEP_LINK",
            .close => "CLOSE",
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
