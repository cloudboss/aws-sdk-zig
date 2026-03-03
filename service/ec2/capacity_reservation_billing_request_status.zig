const std = @import("std");

pub const CapacityReservationBillingRequestStatus = enum {
    pending,
    accepted,
    rejected,
    cancelled,
    revoked,
    expired,

    pub const json_field_names = .{
        .pending = "pending",
        .accepted = "accepted",
        .rejected = "rejected",
        .cancelled = "cancelled",
        .revoked = "revoked",
        .expired = "expired",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "pending",
            .accepted => "accepted",
            .rejected => "rejected",
            .cancelled => "cancelled",
            .revoked => "revoked",
            .expired => "expired",
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
