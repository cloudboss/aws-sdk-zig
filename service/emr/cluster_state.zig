const std = @import("std");

pub const ClusterState = enum {
    starting,
    bootstrapping,
    running,
    waiting,
    terminating,
    terminated,
    terminated_with_errors,

    pub const json_field_names = .{
        .starting = "STARTING",
        .bootstrapping = "BOOTSTRAPPING",
        .running = "RUNNING",
        .waiting = "WAITING",
        .terminating = "TERMINATING",
        .terminated = "TERMINATED",
        .terminated_with_errors = "TERMINATED_WITH_ERRORS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .starting => "STARTING",
            .bootstrapping => "BOOTSTRAPPING",
            .running => "RUNNING",
            .waiting => "WAITING",
            .terminating => "TERMINATING",
            .terminated => "TERMINATED",
            .terminated_with_errors => "TERMINATED_WITH_ERRORS",
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
