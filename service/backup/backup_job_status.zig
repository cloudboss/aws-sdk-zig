const std = @import("std");

pub const BackupJobStatus = enum {
    created,
    pending,
    running,
    aborting,
    aborted,
    completed,
    failed,
    expired,
    partial,
    aggregate_all,
    any,

    pub const json_field_names = .{
        .created = "CREATED",
        .pending = "PENDING",
        .running = "RUNNING",
        .aborting = "ABORTING",
        .aborted = "ABORTED",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .expired = "EXPIRED",
        .partial = "PARTIAL",
        .aggregate_all = "AGGREGATE_ALL",
        .any = "ANY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .pending => "PENDING",
            .running => "RUNNING",
            .aborting => "ABORTING",
            .aborted => "ABORTED",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .expired => "EXPIRED",
            .partial => "PARTIAL",
            .aggregate_all => "AGGREGATE_ALL",
            .any => "ANY",
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
