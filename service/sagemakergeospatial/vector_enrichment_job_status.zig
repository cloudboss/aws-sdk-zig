const std = @import("std");

pub const VectorEnrichmentJobStatus = enum {
    initializing,
    in_progress,
    stopping,
    stopped,
    completed,
    failed,
    deleting,
    deleted,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .in_progress = "IN_PROGRESS",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initializing => "INITIALIZING",
            .in_progress => "IN_PROGRESS",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .deleting => "DELETING",
            .deleted => "DELETED",
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
