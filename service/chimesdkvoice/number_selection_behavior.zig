const std = @import("std");

pub const NumberSelectionBehavior = enum {
    prefer_sticky,
    avoid_sticky,

    pub const json_field_names = .{
        .prefer_sticky = "PreferSticky",
        .avoid_sticky = "AvoidSticky",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .prefer_sticky => "PreferSticky",
            .avoid_sticky => "AvoidSticky",
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
