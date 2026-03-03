const std = @import("std");

pub const OpsItemRelatedItemsFilterKey = enum {
    resource_type,
    association_id,
    resource_uri,

    pub const json_field_names = .{
        .resource_type = "ResourceType",
        .association_id = "AssociationId",
        .resource_uri = "ResourceUri",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_type => "ResourceType",
            .association_id => "AssociationId",
            .resource_uri => "ResourceUri",
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
