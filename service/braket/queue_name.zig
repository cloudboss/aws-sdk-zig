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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
