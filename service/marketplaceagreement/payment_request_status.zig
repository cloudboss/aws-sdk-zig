const std = @import("std");

pub const PaymentRequestStatus = enum {
    validating,
    validation_failed,
    pending_approval,
    approved,
    rejected,
    cancelled,

    pub const json_field_names = .{
        .validating = "VALIDATING",
        .validation_failed = "VALIDATION_FAILED",
        .pending_approval = "PENDING_APPROVAL",
        .approved = "APPROVED",
        .rejected = "REJECTED",
        .cancelled = "CANCELLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .validating => "VALIDATING",
            .validation_failed => "VALIDATION_FAILED",
            .pending_approval => "PENDING_APPROVAL",
            .approved => "APPROVED",
            .rejected => "REJECTED",
            .cancelled => "CANCELLED",
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
