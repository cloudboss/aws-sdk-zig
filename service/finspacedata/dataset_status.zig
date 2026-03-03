const std = @import("std");

/// Status of the dataset process returned from scheduler service.
pub const DatasetStatus = enum {
    pending,
    failed,
    success,
    running,

    pub const json_field_names = .{
        .pending = "PENDING",
        .failed = "FAILED",
        .success = "SUCCESS",
        .running = "RUNNING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .failed => "FAILED",
            .success => "SUCCESS",
            .running => "RUNNING",
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
