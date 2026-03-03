const std = @import("std");

pub const ScanResult = enum {
    clean,
    infected,

    pub const json_field_names = .{
        .clean = "CLEAN",
        .infected = "INFECTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .clean => "CLEAN",
            .infected => "INFECTED",
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
