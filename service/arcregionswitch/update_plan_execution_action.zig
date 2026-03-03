const std = @import("std");

pub const UpdatePlanExecutionAction = enum {
    switch_to_graceful,
    switch_to_ungraceful,
    pause,
    @"resume",

    pub const json_field_names = .{
        .switch_to_graceful = "switchToGraceful",
        .switch_to_ungraceful = "switchToUngraceful",
        .pause = "pause",
        .@"resume" = "resume",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .switch_to_graceful => "switchToGraceful",
            .switch_to_ungraceful => "switchToUngraceful",
            .pause => "pause",
            .@"resume" => "resume",
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
