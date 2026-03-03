const std = @import("std");

pub const PredefinedResolution = enum {
    /// HIGHEST
    highest,
    /// LOWEST
    lowest,
    /// AVERAGE
    average,

    pub const json_field_names = .{
        .highest = "HIGHEST",
        .lowest = "LOWEST",
        .average = "AVERAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .highest => "HIGHEST",
            .lowest => "LOWEST",
            .average => "AVERAGE",
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
