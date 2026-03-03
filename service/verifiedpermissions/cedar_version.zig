const std = @import("std");

pub const CedarVersion = enum {
    cedar_2,
    cedar_4,

    pub const json_field_names = .{
        .cedar_2 = "CEDAR_2",
        .cedar_4 = "CEDAR_4",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cedar_2 => "CEDAR_2",
            .cedar_4 => "CEDAR_4",
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
