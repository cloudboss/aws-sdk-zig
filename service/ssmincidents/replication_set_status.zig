const std = @import("std");

pub const ReplicationSetStatus = enum {
    /// All operations have completed successfully and the replication set is ready
    /// to use
    active,
    /// Replication set is in the process of being created.
    creating,
    /// Replication set is in the process of being updated.
    updating,
    /// Replication set is in the process of being deleted.
    deleting,
    /// Replication set is not healthy and we cannot fix it.
    failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
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
