const std = @import("std");

pub const ValidationSeverity = enum {
    @"error",
    warning,

    pub const json_field_names = .{
        .@"error" = "error",
        .warning = "warning",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .@"error" => "error",
            .warning => "warning",
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
