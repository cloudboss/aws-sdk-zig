const std = @import("std");

pub const OrcFormatVersion = enum {
    v0_11,
    v0_12,

    pub const json_field_names = .{
        .v0_11 = "V0_11",
        .v0_12 = "V0_12",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .v0_11 => "V0_11",
            .v0_12 => "V0_12",
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
