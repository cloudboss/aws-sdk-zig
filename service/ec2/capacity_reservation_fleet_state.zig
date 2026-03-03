const std = @import("std");

pub const CapacityReservationFleetState = enum {
    submitted,
    modifying,
    active,
    partially_fulfilled,
    expiring,
    expired,
    cancelling,
    cancelled,
    failed,

    pub const json_field_names = .{
        .submitted = "submitted",
        .modifying = "modifying",
        .active = "active",
        .partially_fulfilled = "partially_fulfilled",
        .expiring = "expiring",
        .expired = "expired",
        .cancelling = "cancelling",
        .cancelled = "cancelled",
        .failed = "failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "submitted",
            .modifying => "modifying",
            .active => "active",
            .partially_fulfilled => "partially_fulfilled",
            .expiring => "expiring",
            .expired => "expired",
            .cancelling => "cancelling",
            .cancelled => "cancelled",
            .failed => "failed",
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
