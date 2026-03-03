const std = @import("std");

pub const OutputFormat = enum {
    cyclone_dx_1_5,
    inspector,
    inspector_alt,

    pub const json_field_names = .{
        .cyclone_dx_1_5 = "CYCLONE_DX_1_5",
        .inspector = "INSPECTOR",
        .inspector_alt = "INSPECTOR_ALT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cyclone_dx_1_5 => "CYCLONE_DX_1_5",
            .inspector => "INSPECTOR",
            .inspector_alt => "INSPECTOR_ALT",
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
