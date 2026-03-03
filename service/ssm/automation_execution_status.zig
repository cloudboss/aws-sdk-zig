const std = @import("std");

pub const AutomationExecutionStatus = enum {
    pending,
    inprogress,
    waiting,
    success,
    timedout,
    cancelling,
    cancelled,
    failed,
    pending_approval,
    approved,
    rejected,
    scheduled,
    runbook_inprogress,
    pending_change_calendar_override,
    change_calendar_override_approved,
    change_calendar_override_rejected,
    completed_with_success,
    completed_with_failure,
    exited,

    pub const json_field_names = .{
        .pending = "Pending",
        .inprogress = "InProgress",
        .waiting = "Waiting",
        .success = "Success",
        .timedout = "TimedOut",
        .cancelling = "Cancelling",
        .cancelled = "Cancelled",
        .failed = "Failed",
        .pending_approval = "PendingApproval",
        .approved = "Approved",
        .rejected = "Rejected",
        .scheduled = "Scheduled",
        .runbook_inprogress = "RunbookInProgress",
        .pending_change_calendar_override = "PendingChangeCalendarOverride",
        .change_calendar_override_approved = "ChangeCalendarOverrideApproved",
        .change_calendar_override_rejected = "ChangeCalendarOverrideRejected",
        .completed_with_success = "CompletedWithSuccess",
        .completed_with_failure = "CompletedWithFailure",
        .exited = "Exited",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .inprogress => "InProgress",
            .waiting => "Waiting",
            .success => "Success",
            .timedout => "TimedOut",
            .cancelling => "Cancelling",
            .cancelled => "Cancelled",
            .failed => "Failed",
            .pending_approval => "PendingApproval",
            .approved => "Approved",
            .rejected => "Rejected",
            .scheduled => "Scheduled",
            .runbook_inprogress => "RunbookInProgress",
            .pending_change_calendar_override => "PendingChangeCalendarOverride",
            .change_calendar_override_approved => "ChangeCalendarOverrideApproved",
            .change_calendar_override_rejected => "ChangeCalendarOverrideRejected",
            .completed_with_success => "CompletedWithSuccess",
            .completed_with_failure => "CompletedWithFailure",
            .exited => "Exited",
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
