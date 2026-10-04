const std = @import("std");

pub const permissionCheckResultType = enum {
    allowed,
    denied,
    unsure,

    pub const json_field_names = .{
        .allowed = "ALLOWED",
        .denied = "DENIED",
        .unsure = "UNSURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .allowed => "ALLOWED",
            .denied => "DENIED",
            .unsure => "UNSURE",
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
