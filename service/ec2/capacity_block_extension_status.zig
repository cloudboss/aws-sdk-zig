const std = @import("std");

pub const CapacityBlockExtensionStatus = enum {
    payment_pending,
    payment_failed,
    payment_succeeded,

    pub const json_field_names = .{
        .payment_pending = "payment-pending",
        .payment_failed = "payment-failed",
        .payment_succeeded = "payment-succeeded",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .payment_pending => "payment-pending",
            .payment_failed => "payment-failed",
            .payment_succeeded => "payment-succeeded",
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
