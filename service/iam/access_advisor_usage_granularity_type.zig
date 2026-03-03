const std = @import("std");

pub const AccessAdvisorUsageGranularityType = enum {
    service_level,
    action_level,

    pub const json_field_names = .{
        .service_level = "SERVICE_LEVEL",
        .action_level = "ACTION_LEVEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service_level => "SERVICE_LEVEL",
            .action_level => "ACTION_LEVEL",
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
