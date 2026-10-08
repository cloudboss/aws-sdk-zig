const std = @import("std");

/// The NewRelic region (determines API endpoint).
pub const NewRelicRegion = enum {
    /// US region
    us,
    /// EU region
    eu,
    jp,

    pub const json_field_names = .{
        .us = "US",
        .eu = "EU",
        .jp = "JP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .us => "US",
            .eu => "EU",
            .jp => "JP",
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
