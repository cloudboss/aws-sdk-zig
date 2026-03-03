const std = @import("std");

pub const LifecycleState = enum {
    pending,
    pending_wait,
    pending_proceed,
    quarantined,
    in_service,
    terminating,
    terminating_wait,
    terminating_proceed,
    terminated,
    detaching,
    detached,
    entering_standby,
    standby,
    warmed_pending,
    warmed_pending_wait,
    warmed_pending_proceed,
    warmed_terminating,
    warmed_terminating_wait,
    warmed_terminating_proceed,
    warmed_terminated,
    warmed_stopped,
    warmed_running,
    warmed_hibernated,

    pub const json_field_names = .{
        .pending = "Pending",
        .pending_wait = "Pending:Wait",
        .pending_proceed = "Pending:Proceed",
        .quarantined = "Quarantined",
        .in_service = "InService",
        .terminating = "Terminating",
        .terminating_wait = "Terminating:Wait",
        .terminating_proceed = "Terminating:Proceed",
        .terminated = "Terminated",
        .detaching = "Detaching",
        .detached = "Detached",
        .entering_standby = "EnteringStandby",
        .standby = "Standby",
        .warmed_pending = "Warmed:Pending",
        .warmed_pending_wait = "Warmed:Pending:Wait",
        .warmed_pending_proceed = "Warmed:Pending:Proceed",
        .warmed_terminating = "Warmed:Terminating",
        .warmed_terminating_wait = "Warmed:Terminating:Wait",
        .warmed_terminating_proceed = "Warmed:Terminating:Proceed",
        .warmed_terminated = "Warmed:Terminated",
        .warmed_stopped = "Warmed:Stopped",
        .warmed_running = "Warmed:Running",
        .warmed_hibernated = "Warmed:Hibernated",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .pending_wait => "Pending:Wait",
            .pending_proceed => "Pending:Proceed",
            .quarantined => "Quarantined",
            .in_service => "InService",
            .terminating => "Terminating",
            .terminating_wait => "Terminating:Wait",
            .terminating_proceed => "Terminating:Proceed",
            .terminated => "Terminated",
            .detaching => "Detaching",
            .detached => "Detached",
            .entering_standby => "EnteringStandby",
            .standby => "Standby",
            .warmed_pending => "Warmed:Pending",
            .warmed_pending_wait => "Warmed:Pending:Wait",
            .warmed_pending_proceed => "Warmed:Pending:Proceed",
            .warmed_terminating => "Warmed:Terminating",
            .warmed_terminating_wait => "Warmed:Terminating:Wait",
            .warmed_terminating_proceed => "Warmed:Terminating:Proceed",
            .warmed_terminated => "Warmed:Terminated",
            .warmed_stopped => "Warmed:Stopped",
            .warmed_running => "Warmed:Running",
            .warmed_hibernated => "Warmed:Hibernated",
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
