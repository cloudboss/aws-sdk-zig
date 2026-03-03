const std = @import("std");

/// Keep the default value unless you know that your audio EBP markers are
/// incorrectly appearing before your video EBP markers. To correct this
/// problem, set this value to Force.
pub const M2tsForceTsVideoEbpOrder = enum {
    force,
    default,

    pub const json_field_names = .{
        .force = "FORCE",
        .default = "DEFAULT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .force => "FORCE",
            .default => "DEFAULT",
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
