const std = @import("std");

pub const ResourceAttribute = enum {
    properties,
    metadata,
    creation_policy,
    update_policy,
    deletion_policy,
    update_replace_policy,
    tags,

    pub const json_field_names = .{
        .properties = "Properties",
        .metadata = "Metadata",
        .creation_policy = "CreationPolicy",
        .update_policy = "UpdatePolicy",
        .deletion_policy = "DeletionPolicy",
        .update_replace_policy = "UpdateReplacePolicy",
        .tags = "Tags",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .properties => "Properties",
            .metadata => "Metadata",
            .creation_policy => "CreationPolicy",
            .update_policy => "UpdatePolicy",
            .deletion_policy => "DeletionPolicy",
            .update_replace_policy => "UpdateReplacePolicy",
            .tags => "Tags",
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
