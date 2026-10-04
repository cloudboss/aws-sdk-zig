const std = @import("std");

pub const ContainerFleetRemoveAttribute = enum {
    per_instance_container_group_definition,

    pub const json_field_names = .{
        .per_instance_container_group_definition = "PER_INSTANCE_CONTAINER_GROUP_DEFINITION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .per_instance_container_group_definition => "PER_INSTANCE_CONTAINER_GROUP_DEFINITION",
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
