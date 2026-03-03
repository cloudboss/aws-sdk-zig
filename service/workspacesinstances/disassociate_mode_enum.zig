const std = @import("std");

pub const DisassociateModeEnum = enum {
    force,
    no_force,

    pub const json_field_names = .{
        .force = "FORCE",
        .no_force = "NO_FORCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .force => "FORCE",
            .no_force => "NO_FORCE",
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
