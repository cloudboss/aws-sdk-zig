const std = @import("std");

pub const QueueName = enum {
    quantum_tasks_queue,
    jobs_queue,

    pub const json_field_names = .{
        .quantum_tasks_queue = "QUANTUM_TASKS_QUEUE",
        .jobs_queue = "JOBS_QUEUE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .quantum_tasks_queue => "QUANTUM_TASKS_QUEUE",
            .jobs_queue => "JOBS_QUEUE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
