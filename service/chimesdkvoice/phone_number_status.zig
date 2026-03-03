const std = @import("std");

pub const PhoneNumberStatus = enum {
    cancelled,
    portin_cancel_requested,
    portin_in_progress,
    acquire_in_progress,
    acquire_failed,
    unassigned,
    assigned,
    release_in_progress,
    delete_in_progress,
    release_failed,
    delete_failed,

    pub const json_field_names = .{
        .cancelled = "Cancelled",
        .portin_cancel_requested = "PortinCancelRequested",
        .portin_in_progress = "PortinInProgress",
        .acquire_in_progress = "AcquireInProgress",
        .acquire_failed = "AcquireFailed",
        .unassigned = "Unassigned",
        .assigned = "Assigned",
        .release_in_progress = "ReleaseInProgress",
        .delete_in_progress = "DeleteInProgress",
        .release_failed = "ReleaseFailed",
        .delete_failed = "DeleteFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cancelled => "Cancelled",
            .portin_cancel_requested => "PortinCancelRequested",
            .portin_in_progress => "PortinInProgress",
            .acquire_in_progress => "AcquireInProgress",
            .acquire_failed => "AcquireFailed",
            .unassigned => "Unassigned",
            .assigned => "Assigned",
            .release_in_progress => "ReleaseInProgress",
            .delete_in_progress => "DeleteInProgress",
            .release_failed => "ReleaseFailed",
            .delete_failed => "DeleteFailed",
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
