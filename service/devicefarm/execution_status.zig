const std = @import("std");

pub const ExecutionStatus = enum {
    pending,
    pending_concurrnecy,
    pending_device,
    processing,
    scheduling,
    preparing,
    running,
    completed,
    stopping,

    pub const json_field_names = .{
        .pending = "PENDING",
        .pending_concurrnecy = "PENDING_CONCURRENCY",
        .pending_device = "PENDING_DEVICE",
        .processing = "PROCESSING",
        .scheduling = "SCHEDULING",
        .preparing = "PREPARING",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .stopping = "STOPPING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .pending_concurrnecy => "PENDING_CONCURRENCY",
            .pending_device => "PENDING_DEVICE",
            .processing => "PROCESSING",
            .scheduling => "SCHEDULING",
            .preparing => "PREPARING",
            .running => "RUNNING",
            .completed => "COMPLETED",
            .stopping => "STOPPING",
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
