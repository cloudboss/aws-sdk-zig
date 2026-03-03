const std = @import("std");

pub const PublicAccessStatus = enum {
    blocked,
    allowed,

    pub const json_field_names = .{
        .blocked = "BLOCKED",
        .allowed = "ALLOWED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .blocked => "BLOCKED",
            .allowed => "ALLOWED",
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
