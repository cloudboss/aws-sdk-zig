const std = @import("std");

pub const Separator = enum {
    comma,
    ctrla,
    pipe,
    semicolon,
    tab,

    pub const json_field_names = .{
        .comma = "comma",
        .ctrla = "ctrla",
        .pipe = "pipe",
        .semicolon = "semicolon",
        .tab = "tab",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .comma => "comma",
            .ctrla => "ctrla",
            .pipe => "pipe",
            .semicolon => "semicolon",
            .tab => "tab",
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
