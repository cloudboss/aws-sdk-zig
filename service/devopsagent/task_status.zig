const std = @import("std");

/// Possible states of a task throughout its lifecycle
pub const TaskStatus = enum {
    /// Task is awaiting triage analysis
    pending_triage,
    /// Task has been linked to another task
    linked,
    /// Task is created but not yet started
    pending_start,
    /// Task is currently being worked on
    in_progress,
    /// Task is completed but awaiting customer approval (not in use)
    pending_customer_approval,
    /// Task has been completed successfully
    completed,
    /// Task has failed
    failed,
    /// Task has exceeded its time limit
    timed_out,
    /// Task has been canceled
    canceled,
    /// Task has been skipped by triage
    skipped,
    waiting,

    pub const json_field_names = .{
        .pending_triage = "PENDING_TRIAGE",
        .linked = "LINKED",
        .pending_start = "PENDING_START",
        .in_progress = "IN_PROGRESS",
        .pending_customer_approval = "PENDING_CUSTOMER_APPROVAL",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
        .canceled = "CANCELED",
        .skipped = "SKIPPED",
        .waiting = "WAITING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_triage => "PENDING_TRIAGE",
            .linked => "LINKED",
            .pending_start => "PENDING_START",
            .in_progress => "IN_PROGRESS",
            .pending_customer_approval => "PENDING_CUSTOMER_APPROVAL",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .timed_out => "TIMED_OUT",
            .canceled => "CANCELED",
            .skipped => "SKIPPED",
            .waiting => "WAITING",
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
