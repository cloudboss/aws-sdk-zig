const std = @import("std");

/// Video quality, e.g. 'STANDARD' (Outputs only)
pub const ReservationVideoQuality = enum {
    standard,
    enhanced,
    premium,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .enhanced = "ENHANCED",
        .premium = "PREMIUM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "STANDARD",
            .enhanced => "ENHANCED",
            .premium => "PREMIUM",
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
