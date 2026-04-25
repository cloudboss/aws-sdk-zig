const std = @import("std");

pub const TargetStatus = enum {
    creating,
    updating,
    update_unsuccessful,
    deleting,
    ready,
    failed,
    synchronizing,
    synchronize_unsuccessful,
    create_pending_auth,
    update_pending_auth,
    synchronize_pending_auth,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .update_unsuccessful = "UPDATE_UNSUCCESSFUL",
        .deleting = "DELETING",
        .ready = "READY",
        .failed = "FAILED",
        .synchronizing = "SYNCHRONIZING",
        .synchronize_unsuccessful = "SYNCHRONIZE_UNSUCCESSFUL",
        .create_pending_auth = "CREATE_PENDING_AUTH",
        .update_pending_auth = "UPDATE_PENDING_AUTH",
        .synchronize_pending_auth = "SYNCHRONIZE_PENDING_AUTH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .updating => "UPDATING",
            .update_unsuccessful => "UPDATE_UNSUCCESSFUL",
            .deleting => "DELETING",
            .ready => "READY",
            .failed => "FAILED",
            .synchronizing => "SYNCHRONIZING",
            .synchronize_unsuccessful => "SYNCHRONIZE_UNSUCCESSFUL",
            .create_pending_auth => "CREATE_PENDING_AUTH",
            .update_pending_auth => "UPDATE_PENDING_AUTH",
            .synchronize_pending_auth => "SYNCHRONIZE_PENDING_AUTH",
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
