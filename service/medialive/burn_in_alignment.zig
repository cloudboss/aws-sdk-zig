const std = @import("std");

/// Burn In Alignment
pub const BurnInAlignment = enum {
    centered,
    left,
    smart,

    pub const json_field_names = .{
        .centered = "CENTERED",
        .left = "LEFT",
        .smart = "SMART",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .centered => "CENTERED",
            .left => "LEFT",
            .smart => "SMART",
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
