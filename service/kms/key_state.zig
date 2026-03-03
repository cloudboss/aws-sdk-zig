const std = @import("std");

pub const KeyState = enum {
    creating,
    enabled,
    disabled,
    pending_deletion,
    pending_import,
    pending_replica_deletion,
    unavailable,
    updating,

    pub const json_field_names = .{
        .creating = "Creating",
        .enabled = "Enabled",
        .disabled = "Disabled",
        .pending_deletion = "PendingDeletion",
        .pending_import = "PendingImport",
        .pending_replica_deletion = "PendingReplicaDeletion",
        .unavailable = "Unavailable",
        .updating = "Updating",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "Creating",
            .enabled => "Enabled",
            .disabled => "Disabled",
            .pending_deletion => "PendingDeletion",
            .pending_import => "PendingImport",
            .pending_replica_deletion => "PendingReplicaDeletion",
            .unavailable => "Unavailable",
            .updating => "Updating",
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
