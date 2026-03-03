const std = @import("std");

pub const FrequencyUnits = enum {
    ghz,
    mhz,
    khz,

    pub const json_field_names = .{
        .ghz = "GHz",
        .mhz = "MHz",
        .khz = "kHz",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ghz => "GHz",
            .mhz => "MHz",
            .khz => "kHz",
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
