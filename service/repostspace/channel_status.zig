const std = @import("std");

pub const ChannelStatus = enum {
    created,
    creating,
    create_failed,
    deleted,
    deleting,
    delete_failed,

    pub const json_field_names = .{
        .created = "CREATED",
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .deleted = "DELETED",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .creating => "CREATING",
            .create_failed => "CREATE_FAILED",
            .deleted => "DELETED",
            .deleting => "DELETING",
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
