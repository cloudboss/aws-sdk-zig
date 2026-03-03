const std = @import("std");

pub const OrderStatus = enum {
    received,
    pending,
    processing,
    installing,
    fulfilled,
    cancelled,
    preparing,
    in_progress,
    delivered,
    completed,
    @"error",

    pub const json_field_names = .{
        .received = "RECEIVED",
        .pending = "PENDING",
        .processing = "PROCESSING",
        .installing = "INSTALLING",
        .fulfilled = "FULFILLED",
        .cancelled = "CANCELLED",
        .preparing = "PREPARING",
        .in_progress = "IN_PROGRESS",
        .delivered = "DELIVERED",
        .completed = "COMPLETED",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .received => "RECEIVED",
            .pending => "PENDING",
            .processing => "PROCESSING",
            .installing => "INSTALLING",
            .fulfilled => "FULFILLED",
            .cancelled => "CANCELLED",
            .preparing => "PREPARING",
            .in_progress => "IN_PROGRESS",
            .delivered => "DELIVERED",
            .completed => "COMPLETED",
            .@"error" => "ERROR",
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
