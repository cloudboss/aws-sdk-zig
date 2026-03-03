const std = @import("std");

pub const InstanceReplicationStatus = enum {
    instance_replication_complete,
    instance_replication_in_progress,
    instance_replication_failed,
    instance_replica_deleting,
    instance_replication_deletion_failed,
    resource_replication_not_started,

    pub const json_field_names = .{
        .instance_replication_complete = "INSTANCE_REPLICATION_COMPLETE",
        .instance_replication_in_progress = "INSTANCE_REPLICATION_IN_PROGRESS",
        .instance_replication_failed = "INSTANCE_REPLICATION_FAILED",
        .instance_replica_deleting = "INSTANCE_REPLICA_DELETING",
        .instance_replication_deletion_failed = "INSTANCE_REPLICATION_DELETION_FAILED",
        .resource_replication_not_started = "RESOURCE_REPLICATION_NOT_STARTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance_replication_complete => "INSTANCE_REPLICATION_COMPLETE",
            .instance_replication_in_progress => "INSTANCE_REPLICATION_IN_PROGRESS",
            .instance_replication_failed => "INSTANCE_REPLICATION_FAILED",
            .instance_replica_deleting => "INSTANCE_REPLICA_DELETING",
            .instance_replication_deletion_failed => "INSTANCE_REPLICATION_DELETION_FAILED",
            .resource_replication_not_started => "RESOURCE_REPLICATION_NOT_STARTED",
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
