const std = @import("std");

pub const ReservationState = enum {
    active,
    expired,
    cancelled,
    scheduled,
    pending,
    failed,
    delayed,
    unsupported,
    payment_pending,
    payment_failed,
    retired,

    pub const json_field_names = .{
        .active = "active",
        .expired = "expired",
        .cancelled = "cancelled",
        .scheduled = "scheduled",
        .pending = "pending",
        .failed = "failed",
        .delayed = "delayed",
        .unsupported = "unsupported",
        .payment_pending = "payment-pending",
        .payment_failed = "payment-failed",
        .retired = "retired",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "active",
            .expired => "expired",
            .cancelled => "cancelled",
            .scheduled => "scheduled",
            .pending => "pending",
            .failed => "failed",
            .delayed => "delayed",
            .unsupported => "unsupported",
            .payment_pending => "payment-pending",
            .payment_failed => "payment-failed",
            .retired => "retired",
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
