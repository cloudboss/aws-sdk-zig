const std = @import("std");

pub const RelativePosition = enum {
    before_program,
    after_program,

    pub const json_field_names = .{
        .before_program = "BEFORE_PROGRAM",
        .after_program = "AFTER_PROGRAM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .before_program => "BEFORE_PROGRAM",
            .after_program => "AFTER_PROGRAM",
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
