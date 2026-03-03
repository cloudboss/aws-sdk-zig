const std = @import("std");

/// Mode for sensitive data detection
pub const SensitiveDataDetectionMode = enum {
    /// Only detect sensitive data without redaction
    detection,
    /// Detect and redact sensitive data
    detection_and_redaction,

    pub const json_field_names = .{
        .detection = "DETECTION",
        .detection_and_redaction = "DETECTION_AND_REDACTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .detection => "DETECTION",
            .detection_and_redaction => "DETECTION_AND_REDACTION",
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
