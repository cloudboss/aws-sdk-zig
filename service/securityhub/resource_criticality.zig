const std = @import("std");

pub const ResourceCriticality = enum {
    very_high,
    high,
    medium,
    low,
    unknown,

    pub const json_field_names = .{
        .very_high = "Very High",
        .high = "High",
        .medium = "Medium",
        .low = "Low",
        .unknown = "Unknown",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .very_high => "Very High",
            .high => "High",
            .medium => "Medium",
            .low => "Low",
            .unknown => "Unknown",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
