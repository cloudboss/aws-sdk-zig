const std = @import("std");

/// Specify whether this output's video uses the D10 syntax. Keep the default
/// value to not use the syntax. Related settings: When you choose D10 for your
/// MXF profile, you must also set this value to D10.
pub const Mpeg2Syntax = enum {
    default,
    d_10,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .d_10 = "D_10",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .d_10 => "D_10",
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
