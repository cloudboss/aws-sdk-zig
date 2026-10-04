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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
