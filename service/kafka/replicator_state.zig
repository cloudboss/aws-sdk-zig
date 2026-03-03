const std = @import("std");

/// The state of a replicator.
pub const ReplicatorState = enum {
    running,
    creating,
    updating,
    deleting,
    failed,

    pub const json_field_names = .{
        .running = "RUNNING",
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .running => "RUNNING",
            .creating => "CREATING",
            .updating => "UPDATING",
            .deleting => "DELETING",
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
