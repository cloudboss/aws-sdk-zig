const std = @import("std");

pub const CapacityTaskStatus = enum {
    requested,
    in_progress,
    failed,
    completed,
    waiting_for_evacuation,
    cancellation_in_progress,
    cancelled,

    pub const json_field_names = .{
        .requested = "REQUESTED",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .completed = "COMPLETED",
        .waiting_for_evacuation = "WAITING_FOR_EVACUATION",
        .cancellation_in_progress = "CANCELLATION_IN_PROGRESS",
        .cancelled = "CANCELLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .requested => "REQUESTED",
            .in_progress => "IN_PROGRESS",
            .failed => "FAILED",
            .completed => "COMPLETED",
            .waiting_for_evacuation => "WAITING_FOR_EVACUATION",
            .cancellation_in_progress => "CANCELLATION_IN_PROGRESS",
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
