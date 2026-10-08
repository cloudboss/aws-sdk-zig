const std = @import("std");

/// OTP character alphabet used by a NotifyCodeConfiguration.
pub const CodeType = enum {
    /// Digits 0–9.
    numeric,
    /// Letters A–Z (uppercase).
    alpha,
    /// Letters A–Z and digits 0–9.
    alphanumeric,

    pub const json_field_names = .{
        .numeric = "NUMERIC",
        .alpha = "ALPHA",
        .alphanumeric = "ALPHANUMERIC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .numeric => "NUMERIC",
            .alpha => "ALPHA",
            .alphanumeric => "ALPHANUMERIC",
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
