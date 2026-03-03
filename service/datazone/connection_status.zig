const std = @import("std");

pub const ConnectionStatus = enum {
    creating,
    create_failed,
    deleting,
    delete_failed,
    ready,
    updating,
    update_failed,
    deleted,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .ready = "READY",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .create_failed => "CREATE_FAILED",
            .deleting => "DELETING",
            .delete_failed => "DELETE_FAILED",
            .ready => "READY",
            .updating => "UPDATING",
            .update_failed => "UPDATE_FAILED",
            .deleted => "DELETED",
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
