const std = @import("std");

pub const SavingsPlanState = enum {
    payment_pending,
    payment_failed,
    active,
    retired,
    queued,
    queued_deleted,
    pending_return,
    returned,

    pub const json_field_names = .{
        .payment_pending = "payment-pending",
        .payment_failed = "payment-failed",
        .active = "active",
        .retired = "retired",
        .queued = "queued",
        .queued_deleted = "queued-deleted",
        .pending_return = "pending-return",
        .returned = "returned",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .payment_pending => "payment-pending",
            .payment_failed => "payment-failed",
            .active => "active",
            .retired => "retired",
            .queued => "queued",
            .queued_deleted => "queued-deleted",
            .pending_return => "pending-return",
            .returned => "returned",
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
