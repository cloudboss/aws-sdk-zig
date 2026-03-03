const std = @import("std");

pub const NotebookExecutionStatus = enum {
    start_pending,
    starting,
    running,
    finishing,
    finished,
    failing,
    failed,
    stop_pending,
    stopping,
    stopped,

    pub const json_field_names = .{
        .start_pending = "START_PENDING",
        .starting = "STARTING",
        .running = "RUNNING",
        .finishing = "FINISHING",
        .finished = "FINISHED",
        .failing = "FAILING",
        .failed = "FAILED",
        .stop_pending = "STOP_PENDING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .start_pending => "START_PENDING",
            .starting => "STARTING",
            .running => "RUNNING",
            .finishing => "FINISHING",
            .finished => "FINISHED",
            .failing => "FAILING",
            .failed => "FAILED",
            .stop_pending => "STOP_PENDING",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
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
