const std = @import("std");

pub const characterSetType = enum {
    database,
    national,

    pub const json_field_names = .{
        .database = "DATABASE",
        .national = "NATIONAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .database => "DATABASE",
            .national => "NATIONAL",
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
