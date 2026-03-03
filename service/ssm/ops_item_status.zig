const std = @import("std");

pub const OpsItemStatus = enum {
    open,
    in_progress,
    resolved,
    pending,
    timed_out,
    cancelling,
    cancelled,
    failed,
    completed_with_success,
    completed_with_failure,
    scheduled,
    runbook_in_progress,
    pending_change_calendar_override,
    change_calendar_override_approved,
    change_calendar_override_rejected,
    pending_approval,
    approved,
    revoked,
    rejected,
    closed,

    pub const json_field_names = .{
        .open = "Open",
        .in_progress = "InProgress",
        .resolved = "Resolved",
        .pending = "Pending",
        .timed_out = "TimedOut",
        .cancelling = "Cancelling",
        .cancelled = "Cancelled",
        .failed = "Failed",
        .completed_with_success = "CompletedWithSuccess",
        .completed_with_failure = "CompletedWithFailure",
        .scheduled = "Scheduled",
        .runbook_in_progress = "RunbookInProgress",
        .pending_change_calendar_override = "PendingChangeCalendarOverride",
        .change_calendar_override_approved = "ChangeCalendarOverrideApproved",
        .change_calendar_override_rejected = "ChangeCalendarOverrideRejected",
        .pending_approval = "PendingApproval",
        .approved = "Approved",
        .revoked = "Revoked",
        .rejected = "Rejected",
        .closed = "Closed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .open => "Open",
            .in_progress => "InProgress",
            .resolved => "Resolved",
            .pending => "Pending",
            .timed_out => "TimedOut",
            .cancelling => "Cancelling",
            .cancelled => "Cancelled",
            .failed => "Failed",
            .completed_with_success => "CompletedWithSuccess",
            .completed_with_failure => "CompletedWithFailure",
            .scheduled => "Scheduled",
            .runbook_in_progress => "RunbookInProgress",
            .pending_change_calendar_override => "PendingChangeCalendarOverride",
            .change_calendar_override_approved => "ChangeCalendarOverrideApproved",
            .change_calendar_override_rejected => "ChangeCalendarOverrideRejected",
            .pending_approval => "PendingApproval",
            .approved => "Approved",
            .revoked => "Revoked",
            .rejected => "Rejected",
            .closed => "Closed",
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
