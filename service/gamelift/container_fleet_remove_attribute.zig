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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
