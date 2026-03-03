const std = @import("std");

pub const InstanceCollectionType = enum {
    instance_fleet,
    instance_group,

    pub const json_field_names = .{
        .instance_fleet = "INSTANCE_FLEET",
        .instance_group = "INSTANCE_GROUP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance_fleet => "INSTANCE_FLEET",
            .instance_group => "INSTANCE_GROUP",
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
