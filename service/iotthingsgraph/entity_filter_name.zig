const std = @import("std");

pub const EntityFilterName = enum {
    name,
    namespace,
    semantic_type_path,
    referenced_entity_id,

    pub const json_field_names = .{
        .name = "NAME",
        .namespace = "NAMESPACE",
        .semantic_type_path = "SEMANTIC_TYPE_PATH",
        .referenced_entity_id = "REFERENCED_ENTITY_ID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "NAME",
            .namespace => "NAMESPACE",
            .semantic_type_path => "SEMANTIC_TYPE_PATH",
            .referenced_entity_id => "REFERENCED_ENTITY_ID",
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
