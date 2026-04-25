const std = @import("std");

pub const ClusterStatus = enum {
    creating,
    active,
    updating,
    deleting,
    create_failed,
    delete_failed,
    update_failed,
    suspending,
    suspended,
    resuming,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .create_failed = "CREATE_FAILED",
        .delete_failed = "DELETE_FAILED",
        .update_failed = "UPDATE_FAILED",
        .suspending = "SUSPENDING",
        .suspended = "SUSPENDED",
        .resuming = "RESUMING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .active => "ACTIVE",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .create_failed => "CREATE_FAILED",
            .delete_failed => "DELETE_FAILED",
            .update_failed => "UPDATE_FAILED",
            .suspending => "SUSPENDING",
            .suspended => "SUSPENDED",
            .resuming => "RESUMING",
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
