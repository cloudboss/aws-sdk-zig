const std = @import("std");

pub const StageStatus = enum {
    creating,
    ready_to_deploy,
    starting,
    in_progress,
    deployed,
    failed,
    stopping,
    stopped,

    pub const json_field_names = .{
        .creating = "CREATING",
        .ready_to_deploy = "READYTODEPLOY",
        .starting = "STARTING",
        .in_progress = "INPROGRESS",
        .deployed = "DEPLOYED",
        .failed = "FAILED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .ready_to_deploy => "READYTODEPLOY",
            .starting => "STARTING",
            .in_progress => "INPROGRESS",
            .deployed => "DEPLOYED",
            .failed => "FAILED",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
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
