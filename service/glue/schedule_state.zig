const std = @import("std");

pub const ScheduleState = enum {
    scheduled,
    not_scheduled,
    transitioning,

    pub const json_field_names = .{
        .scheduled = "SCHEDULED",
        .not_scheduled = "NOT_SCHEDULED",
        .transitioning = "TRANSITIONING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scheduled => "SCHEDULED",
            .not_scheduled => "NOT_SCHEDULED",
            .transitioning => "TRANSITIONING",
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
