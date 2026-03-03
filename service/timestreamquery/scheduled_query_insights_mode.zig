const std = @import("std");

pub const ScheduledQueryInsightsMode = enum {
    enabled_with_rate_control,
    disabled,

    pub const json_field_names = .{
        .enabled_with_rate_control = "ENABLED_WITH_RATE_CONTROL",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled_with_rate_control => "ENABLED_WITH_RATE_CONTROL",
            .disabled => "DISABLED",
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
