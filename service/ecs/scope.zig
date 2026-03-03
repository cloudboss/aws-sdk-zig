const std = @import("std");

pub const Scope = enum {
    task,
    shared,

    pub const json_field_names = .{
        .task = "task",
        .shared = "shared",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .task => "task",
            .shared => "shared",
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
