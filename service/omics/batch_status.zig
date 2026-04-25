const std = @import("std");

pub const BatchStatus = enum {
    pending,
    submitting,
    inprogress,
    stopping,
    cancelled,
    failed,
    processed,
    runs_deleting,
    runs_deleted,

    pub const json_field_names = .{
        .pending = "PENDING",
        .submitting = "SUBMITTING",
        .inprogress = "INPROGRESS",
        .stopping = "STOPPING",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
        .processed = "PROCESSED",
        .runs_deleting = "RUNS_DELETING",
        .runs_deleted = "RUNS_DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .submitting => "SUBMITTING",
            .inprogress => "INPROGRESS",
            .stopping => "STOPPING",
            .cancelled => "CANCELLED",
            .failed => "FAILED",
            .processed => "PROCESSED",
            .runs_deleting => "RUNS_DELETING",
            .runs_deleted => "RUNS_DELETED",
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
