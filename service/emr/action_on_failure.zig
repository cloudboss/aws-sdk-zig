const std = @import("std");

pub const ActionOnFailure = enum {
    terminate_job_flow,
    terminate_cluster,
    cancel_and_wait,
    @"continue",

    pub const json_field_names = .{
        .terminate_job_flow = "TERMINATE_JOB_FLOW",
        .terminate_cluster = "TERMINATE_CLUSTER",
        .cancel_and_wait = "CANCEL_AND_WAIT",
        .@"continue" = "CONTINUE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .terminate_job_flow => "TERMINATE_JOB_FLOW",
            .terminate_cluster => "TERMINATE_CLUSTER",
            .cancel_and_wait => "CANCEL_AND_WAIT",
            .@"continue" => "CONTINUE",
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
