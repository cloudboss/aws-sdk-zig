const std = @import("std");

pub const RuleTypeOption = enum {
    forward,
    system,
    recursive,
    delegate,

    pub const json_field_names = .{
        .forward = "FORWARD",
        .system = "SYSTEM",
        .recursive = "RECURSIVE",
        .delegate = "DELEGATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .forward => "FORWARD",
            .system => "SYSTEM",
            .recursive => "RECURSIVE",
            .delegate => "DELEGATE",
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
