const std = @import("std");

/// The reason for which the configuration elements or attributes were
/// sanitized.
pub const SanitizationWarningReason = enum {
    disallowed_element_removed,
    disallowed_attribute_removed,
    invalid_attribute_value_removed,

    pub const json_field_names = .{
        .disallowed_element_removed = "DISALLOWED_ELEMENT_REMOVED",
        .disallowed_attribute_removed = "DISALLOWED_ATTRIBUTE_REMOVED",
        .invalid_attribute_value_removed = "INVALID_ATTRIBUTE_VALUE_REMOVED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disallowed_element_removed => "DISALLOWED_ELEMENT_REMOVED",
            .disallowed_attribute_removed => "DISALLOWED_ATTRIBUTE_REMOVED",
            .invalid_attribute_value_removed => "INVALID_ATTRIBUTE_VALUE_REMOVED",
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
