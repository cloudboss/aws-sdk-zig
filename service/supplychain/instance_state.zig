const std = @import("std");

pub const InstanceState = enum {
    initializing,
    active,
    create_failed,
    delete_failed,
    deleting,
    deleted,

    pub const json_field_names = .{
        .initializing = "Initializing",
        .active = "Active",
        .create_failed = "CreateFailed",
        .delete_failed = "DeleteFailed",
        .deleting = "Deleting",
        .deleted = "Deleted",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initializing => "Initializing",
            .active => "Active",
            .create_failed => "CreateFailed",
            .delete_failed => "DeleteFailed",
            .deleting => "Deleting",
            .deleted => "Deleted",
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
