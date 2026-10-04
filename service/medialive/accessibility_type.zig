const std = @import("std");

/// Accessibility Type
pub const AccessibilityType = enum {
    does_not_implement_accessibility_features,
    implements_accessibility_features,

    pub const json_field_names = .{
        .does_not_implement_accessibility_features = "DOES_NOT_IMPLEMENT_ACCESSIBILITY_FEATURES",
        .implements_accessibility_features = "IMPLEMENTS_ACCESSIBILITY_FEATURES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .does_not_implement_accessibility_features => "DOES_NOT_IMPLEMENT_ACCESSIBILITY_FEATURES",
            .implements_accessibility_features => "IMPLEMENTS_ACCESSIBILITY_FEATURES",
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
