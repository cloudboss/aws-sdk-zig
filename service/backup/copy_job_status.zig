const std = @import("std");

pub const CopyJobStatus = enum {
    created,
    running,
    aborting,
    aborted,
    completing,
    completed,
    failing,
    failed,
    partial,
    aggregate_all,
    any,

    pub const json_field_names = .{
        .created = "CREATED",
        .running = "RUNNING",
        .aborting = "ABORTING",
        .aborted = "ABORTED",
        .completing = "COMPLETING",
        .completed = "COMPLETED",
        .failing = "FAILING",
        .failed = "FAILED",
        .partial = "PARTIAL",
        .aggregate_all = "AGGREGATE_ALL",
        .any = "ANY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .running => "RUNNING",
            .aborting => "ABORTING",
            .aborted => "ABORTED",
            .completing => "COMPLETING",
            .completed => "COMPLETED",
            .failing => "FAILING",
            .failed => "FAILED",
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
