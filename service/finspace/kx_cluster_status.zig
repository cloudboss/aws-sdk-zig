const std = @import("std");

pub const KxClusterStatus = enum {
    pending,
    creating,
    create_failed,
    running,
    updating,
    deleting,
    deleted,
    delete_failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .running = "RUNNING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .delete_failed = "DELETE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .creating => "CREATING",
            .create_failed => "CREATE_FAILED",
            .running => "RUNNING",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .deleted => "DELETED",
            .delete_failed => "DELETE_FAILED",
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
