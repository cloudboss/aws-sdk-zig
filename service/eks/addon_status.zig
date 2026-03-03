const std = @import("std");

pub const AddonStatus = enum {
    creating,
    active,
    create_failed,
    updating,
    deleting,
    delete_failed,
    degraded,
    update_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .create_failed = "CREATE_FAILED",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .degraded = "DEGRADED",
        .update_failed = "UPDATE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .active => "ACTIVE",
            .create_failed => "CREATE_FAILED",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .delete_failed => "DELETE_FAILED",
            .degraded => "DEGRADED",
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
