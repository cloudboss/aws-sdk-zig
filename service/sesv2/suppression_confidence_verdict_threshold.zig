const std = @import("std");

/// The confidence level threshold for suppression validation:
///
/// * `MEDIUM` – Allows emails to be sent to addresses with medium or high
///   delivery likelihood.
///
/// * `HIGH` – Allows emails to be sent only to addresses with high delivery
///   likelihood.
///
/// * `MANAGED` – Managed confidence threshold where Amazon SES automatically
///   determines the appropriate level.
pub const SuppressionConfidenceVerdictThreshold = enum {
    medium,
    high,
    managed,

    pub const json_field_names = .{
        .medium = "MEDIUM",
        .high = "HIGH",
        .managed = "MANAGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .medium => "MEDIUM",
            .high => "HIGH",
            .managed => "MANAGED",
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
