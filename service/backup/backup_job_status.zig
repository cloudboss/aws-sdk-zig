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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
