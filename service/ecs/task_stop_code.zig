const std = @import("std");

pub const TaskStopCode = enum {
    task_failed_to_start,
    essential_container_exited,
    user_initiated,
    service_scheduler_initiated,
    spot_interruption,
    termination_notice,
    infrastructure_health,

    pub const json_field_names = .{
        .task_failed_to_start = "TaskFailedToStart",
        .essential_container_exited = "EssentialContainerExited",
        .user_initiated = "UserInitiated",
        .service_scheduler_initiated = "ServiceSchedulerInitiated",
        .spot_interruption = "SpotInterruption",
        .termination_notice = "TerminationNotice",
        .infrastructure_health = "InfrastructureHealth",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .task_failed_to_start => "TaskFailedToStart",
            .essential_container_exited => "EssentialContainerExited",
            .user_initiated => "UserInitiated",
            .service_scheduler_initiated => "ServiceSchedulerInitiated",
            .spot_interruption => "SpotInterruption",
            .termination_notice => "TerminationNotice",
            .infrastructure_health => "InfrastructureHealth",
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
