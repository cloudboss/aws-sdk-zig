const std = @import("std");

pub const ObjectType = enum {
    node,
    leaf_node,
    policy,
    index,

    pub const json_field_names = .{
        .node = "NODE",
        .leaf_node = "LEAF_NODE",
        .policy = "POLICY",
        .index = "INDEX",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .node => "NODE",
            .leaf_node => "LEAF_NODE",
            .policy => "POLICY",
            .index => "INDEX",
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
