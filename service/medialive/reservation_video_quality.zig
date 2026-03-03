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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
