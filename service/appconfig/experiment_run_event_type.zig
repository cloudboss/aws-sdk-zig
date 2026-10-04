const std = @import("std");

pub const ExperimentRunEventType = enum {
    run_started,
    exposure_updated,
    overrides_updated,
    run_stopped,

    pub const json_field_names = .{
        .run_started = "RUN_STARTED",
        .exposure_updated = "EXPOSURE_UPDATED",
        .overrides_updated = "OVERRIDES_UPDATED",
        .run_stopped = "RUN_STOPPED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .run_started => "RUN_STARTED",
            .exposure_updated => "EXPOSURE_UPDATED",
            .overrides_updated => "OVERRIDES_UPDATED",
            .run_stopped => "RUN_STOPPED",
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
