const std = @import("std");

pub const TableStatus = enum {
    creating,
    updating,
    deleting,
    active,
    inaccessible_encryption_credentials,
    archiving,
    archived,
    replication_not_authorized,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .active = "ACTIVE",
        .inaccessible_encryption_credentials = "INACCESSIBLE_ENCRYPTION_CREDENTIALS",
        .archiving = "ARCHIVING",
        .archived = "ARCHIVED",
        .replication_not_authorized = "REPLICATION_NOT_AUTHORIZED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .active => "ACTIVE",
            .inaccessible_encryption_credentials => "INACCESSIBLE_ENCRYPTION_CREDENTIALS",
            .archiving => "ARCHIVING",
            .archived => "ARCHIVED",
            .replication_not_authorized => "REPLICATION_NOT_AUTHORIZED",
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
