const std = @import("std");

pub const ConnectorState = enum {
    creating,
    create_failed,
    active,
    updating,
    update_failed,
    deleting,
    deleted,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .create_failed => "CREATE_FAILED",
            .active => "ACTIVE",
            .updating => "UPDATING",
            .update_failed => "UPDATE_FAILED",
            .deleting => "DELETING",
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
