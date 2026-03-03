const std = @import("std");

pub const VerificationStatus = enum {
    pending_customer_action,
    in_progress,
    failed,
    succeeded,
    rejected,

    pub const json_field_names = .{
        .pending_customer_action = "PENDING_CUSTOMER_ACTION",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .rejected = "REJECTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_customer_action => "PENDING_CUSTOMER_ACTION",
            .in_progress => "IN_PROGRESS",
            .failed => "FAILED",
            .succeeded => "SUCCEEDED",
            .rejected => "REJECTED",
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
