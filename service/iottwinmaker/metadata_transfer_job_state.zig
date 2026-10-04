const std = @import("std");

pub const MetadataTransferJobState = enum {
    validating,
    pending,
    running,
    cancelling,
    @"error",
    completed,
    cancelled,

    pub const json_field_names = .{
        .validating = "VALIDATING",
        .pending = "PENDING",
        .running = "RUNNING",
        .cancelling = "CANCELLING",
        .@"error" = "ERROR",
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .validating => "VALIDATING",
            .pending => "PENDING",
            .running => "RUNNING",
            .cancelling => "CANCELLING",
            .@"error" => "ERROR",
            .completed => "COMPLETED",
            .cancelled => "CANCELLED",
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
