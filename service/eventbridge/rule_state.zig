const std = @import("std");

pub const RuleState = enum {
    enabled,
    disabled,
    enabled_with_all_cloudtrail_management_events,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .enabled_with_all_cloudtrail_management_events = "ENABLED_WITH_ALL_CLOUDTRAIL_MANAGEMENT_EVENTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .disabled => "DISABLED",
            .enabled_with_all_cloudtrail_management_events => "ENABLED_WITH_ALL_CLOUDTRAIL_MANAGEMENT_EVENTS",
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
