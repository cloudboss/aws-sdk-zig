const std = @import("std");

pub const AccountRoleStatus = enum {
    ready,
    creating,
    pending_deletion,
    deleting,
    deleted,

    pub const json_field_names = .{
        .ready = "READY",
        .creating = "CREATING",
        .pending_deletion = "PENDING_DELETION",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ready => "READY",
            .creating => "CREATING",
            .pending_deletion => "PENDING_DELETION",
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
