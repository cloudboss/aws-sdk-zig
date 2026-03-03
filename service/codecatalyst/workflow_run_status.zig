const std = @import("std");

pub const WorkflowRunStatus = enum {
    succeeded,
    failed,
    stopped,
    superseded,
    cancelled,
    not_run,
    validating,
    provisioning,
    in_progress,
    stopping,
    abandoned,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .stopped = "STOPPED",
        .superseded = "SUPERSEDED",
        .cancelled = "CANCELLED",
        .not_run = "NOT_RUN",
        .validating = "VALIDATING",
        .provisioning = "PROVISIONING",
        .in_progress = "IN_PROGRESS",
        .stopping = "STOPPING",
        .abandoned = "ABANDONED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
            .stopped => "STOPPED",
            .superseded => "SUPERSEDED",
            .cancelled => "CANCELLED",
            .not_run => "NOT_RUN",
            .validating => "VALIDATING",
            .provisioning => "PROVISIONING",
            .in_progress => "IN_PROGRESS",
            .stopping => "STOPPING",
            .abandoned => "ABANDONED",
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
