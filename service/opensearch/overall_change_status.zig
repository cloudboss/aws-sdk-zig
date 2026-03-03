const std = @import("std");

/// The overall status value of the domain configuration change.
pub const OverallChangeStatus = enum {
    pending,
    processing,
    completed,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .processing = "PROCESSING",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .processing => "PROCESSING",
            .completed => "COMPLETED",
            .failed => "FAILED",
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
