const std = @import("std");

pub const ScalingStatusType = enum {
    active,
    update_requested,
    updating,
    delete_requested,
    deleting,
    deleted,
    @"error",

    pub const json_field_names = .{
        .active = "ACTIVE",
        .update_requested = "UPDATE_REQUESTED",
        .updating = "UPDATING",
        .delete_requested = "DELETE_REQUESTED",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .update_requested => "UPDATE_REQUESTED",
            .updating => "UPDATING",
            .delete_requested => "DELETE_REQUESTED",
            .deleting => "DELETING",
            .deleted => "DELETED",
            .@"error" => "ERROR",
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
