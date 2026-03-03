const std = @import("std");

pub const BridgeState = enum {
    creating,
    standby,
    starting,
    deploying,
    active,
    stopping,
    deleting,
    deleted,
    start_failed,
    start_pending,
    stop_failed,
    updating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .standby = "STANDBY",
        .starting = "STARTING",
        .deploying = "DEPLOYING",
        .active = "ACTIVE",
        .stopping = "STOPPING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .start_failed = "START_FAILED",
        .start_pending = "START_PENDING",
        .stop_failed = "STOP_FAILED",
        .updating = "UPDATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .standby => "STANDBY",
            .starting => "STARTING",
            .deploying => "DEPLOYING",
            .active => "ACTIVE",
            .stopping => "STOPPING",
            .deleting => "DELETING",
            .deleted => "DELETED",
            .start_failed => "START_FAILED",
            .start_pending => "START_PENDING",
            .stop_failed => "STOP_FAILED",
            .updating => "UPDATING",
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
