const std = @import("std");

pub const CapabilityStatus = enum {
    creating,
    create_failed,
    updating,
    deleting,
    delete_failed,
    active,
    degraded,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .active = "ACTIVE",
        .degraded = "DEGRADED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .create_failed => "CREATE_FAILED",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .delete_failed => "DELETE_FAILED",
            .active => "ACTIVE",
            .degraded => "DEGRADED",
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
