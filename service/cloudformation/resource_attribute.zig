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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
