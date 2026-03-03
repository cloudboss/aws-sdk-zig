const std = @import("std");

/// Placeholder documentation for ChannelState
pub const ChannelState = enum {
    creating,
    create_failed,
    idle,
    starting,
    running,
    recovering,
    stopping,
    deleting,
    deleted,
    updating,
    update_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .idle = "IDLE",
        .starting = "STARTING",
        .running = "RUNNING",
        .recovering = "RECOVERING",
        .stopping = "STOPPING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .create_failed => "CREATE_FAILED",
            .idle => "IDLE",
            .starting => "STARTING",
            .running => "RUNNING",
            .recovering => "RECOVERING",
            .stopping => "STOPPING",
            .deleting => "DELETING",
            .deleted => "DELETED",
            .updating => "UPDATING",
            .update_failed => "UPDATE_FAILED",
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
