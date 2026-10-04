const std = @import("std");

pub const ParameterType = enum {
    default,
    node_type_specific,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .node_type_specific = "NODE_TYPE_SPECIFIC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .node_type_specific => "NODE_TYPE_SPECIFIC",
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
