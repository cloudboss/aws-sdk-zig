const std = @import("std");

/// The current status of a cluster.
pub const ClusterStatus = enum {
    creating,
    active,
    idle,
    inactive,
    updating,
    deleting,
    deleted,
    failed,
    pending_setup,
    pending_delete,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .idle = "IDLE",
        .inactive = "INACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .failed = "FAILED",
        .pending_setup = "PENDING_SETUP",
        .pending_delete = "PENDING_DELETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .active => "ACTIVE",
            .idle => "IDLE",
            .inactive => "INACTIVE",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .deleted => "DELETED",
            .failed => "FAILED",
            .pending_setup => "PENDING_SETUP",
            .pending_delete => "PENDING_DELETE",
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
