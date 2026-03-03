const std = @import("std");

pub const MemberStatus = enum {
    creating,
    available,
    create_failed,
    updating,
    deleting,
    deleted,
    inaccessible_encryption_key,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .create_failed = "CREATE_FAILED",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .inaccessible_encryption_key = "INACCESSIBLE_ENCRYPTION_KEY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .available => "AVAILABLE",
            .create_failed => "CREATE_FAILED",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .deleted => "DELETED",
            .inaccessible_encryption_key => "INACCESSIBLE_ENCRYPTION_KEY",
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
