const std = @import("std");

pub const SeverityLevel = enum {
    informative,
    low,
    medium,
    high,

    pub const json_field_names = .{
        .informative = "Informative",
        .low = "Low",
        .medium = "Medium",
        .high = "High",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .informative => "Informative",
            .low => "Low",
            .medium => "Medium",
            .high => "High",
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
