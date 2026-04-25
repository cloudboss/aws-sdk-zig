const std = @import("std");

/// The status of a capability. Possible values: `creating`, `create_failed`,
/// `active`, `updating`, `update_failed`, `deleting`, `delete_failed`.
pub const CapabilityStatus = enum {
    creating,
    create_failed,
    active,
    updating,
    update_failed,
    deleting,
    delete_failed,

    pub const json_field_names = .{
        .creating = "creating",
        .create_failed = "create_failed",
        .active = "active",
        .updating = "updating",
        .update_failed = "update_failed",
        .deleting = "deleting",
        .delete_failed = "delete_failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "creating",
            .create_failed => "create_failed",
            .active => "active",
            .updating => "updating",
            .update_failed => "update_failed",
            .deleting => "deleting",
            .delete_failed => "delete_failed",
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
