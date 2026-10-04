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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
