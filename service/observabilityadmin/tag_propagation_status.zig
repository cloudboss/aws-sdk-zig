const std = @import("std");

/// The health status of tag propagation for a centralization rule. This status
/// is independent of the overall `RuleHealth` for log delivery.
pub const TagPropagationStatus = enum {
    healthy,
    unhealthy,

    pub const json_field_names = .{
        .healthy = "Healthy",
        .unhealthy = "Unhealthy",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .healthy => "Healthy",
            .unhealthy => "Unhealthy",
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
