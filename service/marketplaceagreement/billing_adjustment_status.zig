const std = @import("std");

pub const BillingAdjustmentStatus = enum {
    pending,
    validation_failed,
    completed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .validation_failed = "VALIDATION_FAILED",
        .completed = "COMPLETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .validation_failed => "VALIDATION_FAILED",
            .completed => "COMPLETED",
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
