const std = @import("std");

pub const RouteServerEndpointState = enum {
    pending,
    available,
    deleting,
    deleted,
    failing,
    failed,
    delete_failed,

    pub const json_field_names = .{
        .pending = "pending",
        .available = "available",
        .deleting = "deleting",
        .deleted = "deleted",
        .failing = "failing",
        .failed = "failed",
        .delete_failed = "delete-failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "pending",
            .available => "available",
            .deleting => "deleting",
            .deleted => "deleted",
            .failing => "failing",
            .failed => "failed",
            .delete_failed => "delete-failed",
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
