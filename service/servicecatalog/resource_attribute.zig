const std = @import("std");

pub const ResourceAttribute = enum {
    properties,
    metadata,
    creationpolicy,
    updatepolicy,
    deletionpolicy,
    tags,

    pub const json_field_names = .{
        .properties = "PROPERTIES",
        .metadata = "METADATA",
        .creationpolicy = "CREATIONPOLICY",
        .updatepolicy = "UPDATEPOLICY",
        .deletionpolicy = "DELETIONPOLICY",
        .tags = "TAGS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .properties => "PROPERTIES",
            .metadata => "METADATA",
            .creationpolicy => "CREATIONPOLICY",
            .updatepolicy => "UPDATEPOLICY",
            .deletionpolicy => "DELETIONPOLICY",
            .tags => "TAGS",
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
