const std = @import("std");

pub const TraceSegmentDestination = enum {
    x_ray,
    cloud_watch_logs,

    pub const json_field_names = .{
        .x_ray = "XRay",
        .cloud_watch_logs = "CloudWatchLogs",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .x_ray => "XRay",
            .cloud_watch_logs => "CloudWatchLogs",
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
