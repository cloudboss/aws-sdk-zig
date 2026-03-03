const std = @import("std");

pub const ConfigurationItemStatus = enum {
    ok,
    resource_discovered,
    resource_not_recorded,
    resource_deleted,
    resource_deleted_not_recorded,

    pub const json_field_names = .{
        .ok = "OK",
        .resource_discovered = "ResourceDiscovered",
        .resource_not_recorded = "ResourceNotRecorded",
        .resource_deleted = "ResourceDeleted",
        .resource_deleted_not_recorded = "ResourceDeletedNotRecorded",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ok => "OK",
            .resource_discovered => "ResourceDiscovered",
            .resource_not_recorded => "ResourceNotRecorded",
            .resource_deleted => "ResourceDeleted",
            .resource_deleted_not_recorded => "ResourceDeletedNotRecorded",
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
