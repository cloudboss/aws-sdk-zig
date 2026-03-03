const std = @import("std");

pub const DomainStatus = enum {
    creating,
    available,
    creation_failed,
    deleting,
    deleted,
    deletion_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .creation_failed = "CREATION_FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .deletion_failed = "DELETION_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .available => "AVAILABLE",
            .creation_failed => "CREATION_FAILED",
            .deleting => "DELETING",
            .deleted => "DELETED",
            .deletion_failed => "DELETION_FAILED",
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
