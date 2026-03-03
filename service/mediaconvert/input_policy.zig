const std = @import("std");

/// An input policy allows or disallows a job you submit to run based on the
/// conditions that you specify.
pub const InputPolicy = enum {
    allowed,
    disallowed,

    pub const json_field_names = .{
        .allowed = "ALLOWED",
        .disallowed = "DISALLOWED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .allowed => "ALLOWED",
            .disallowed => "DISALLOWED",
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
