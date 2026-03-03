const std = @import("std");

pub const ContainerInstanceField = enum {
    tags,
    container_instance_health,

    pub const json_field_names = .{
        .tags = "TAGS",
        .container_instance_health = "CONTAINER_INSTANCE_HEALTH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tags => "TAGS",
            .container_instance_health => "CONTAINER_INSTANCE_HEALTH",
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
