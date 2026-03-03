const std = @import("std");

pub const CapacityReservationState = enum {
    active,
    expired,
    cancelled,
    pending,
    failed,
    scheduled,
    payment_pending,
    payment_failed,
    assessing,
    delayed,
    unsupported,
    unavailable,

    pub const json_field_names = .{
        .active = "active",
        .expired = "expired",
        .cancelled = "cancelled",
        .pending = "pending",
        .failed = "failed",
        .scheduled = "scheduled",
        .payment_pending = "payment-pending",
        .payment_failed = "payment-failed",
        .assessing = "assessing",
        .delayed = "delayed",
        .unsupported = "unsupported",
        .unavailable = "unavailable",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "active",
            .expired => "expired",
            .cancelled => "cancelled",
            .pending => "pending",
            .failed => "failed",
            .scheduled => "scheduled",
            .payment_pending => "payment-pending",
            .payment_failed => "payment-failed",
            .assessing => "assessing",
            .delayed => "delayed",
            .unsupported => "unsupported",
            .unavailable => "unavailable",
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
