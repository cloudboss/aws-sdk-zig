const std = @import("std");

/// The confidence threshold for a DNS Firewall Advanced rule. One of:
///
/// * `LOW` — Provides the highest detection rate for threats, but also
///   increases false positives.
///
/// * `MEDIUM` — Provides a balance between detecting threats and false
///   positives.
///
/// * `HIGH` — Detects only the most well-corroborated threats with a low rate
///   of false positives.
pub const ConfidenceThreshold = enum {
    low,
    medium,
    high,

    pub const json_field_names = .{
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .low => "LOW",
            .medium => "MEDIUM",
            .high => "HIGH",
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
