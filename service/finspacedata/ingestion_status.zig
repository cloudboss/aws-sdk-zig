const std = @import("std");

/// Status of the ingestion process returned from scheduler service.
pub const IngestionStatus = enum {
    pending,
    failed,
    success,
    running,
    stop_requested,

    pub const json_field_names = .{
        .pending = "PENDING",
        .failed = "FAILED",
        .success = "SUCCESS",
        .running = "RUNNING",
        .stop_requested = "STOP_REQUESTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .failed => "FAILED",
            .success => "SUCCESS",
            .running => "RUNNING",
            .stop_requested => "STOP_REQUESTED",
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
