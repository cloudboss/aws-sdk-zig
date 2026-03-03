const std = @import("std");

pub const Atime = enum {
    none,
    best_effort,

    pub const json_field_names = .{
        .none = "NONE",
        .best_effort = "BEST_EFFORT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .best_effort => "BEST_EFFORT",
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
