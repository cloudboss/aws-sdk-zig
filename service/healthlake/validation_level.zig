const std = @import("std");

pub const ValidationLevel = enum {
    strict,
    structure_only,
    minimal,

    pub const json_field_names = .{
        .strict = "strict",
        .structure_only = "structure-only",
        .minimal = "minimal",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .strict => "strict",
            .structure_only => "structure-only",
            .minimal => "minimal",
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
