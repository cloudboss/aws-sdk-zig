const std = @import("std");

/// Indicates whether deletion protection is `ENABLED` or `DISABLED` for the
/// collection. When deletion protection is `ENABLED`, the collection cannot be
/// deleted.
pub const DeletionProtection = enum {
    /// Deletion protection enabled
    enabled,
    /// Deletion protection disabled
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .disabled => "DISABLED",
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
