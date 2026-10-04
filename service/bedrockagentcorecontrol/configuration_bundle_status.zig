const std = @import("std");

pub const ConfigurationBundleStatus = enum {
    active,
    creating,
    create_failed,
    updating,
    update_failed,
    deleting,
    delete_failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .creating => "CREATING",
            .create_failed => "CREATE_FAILED",
            .updating => "UPDATING",
            .update_failed => "UPDATE_FAILED",
            .deleting => "DELETING",
            .delete_failed => "DELETE_FAILED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
