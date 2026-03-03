const std = @import("std");

pub const RecommendationTarget = enum {
    same_instance_family,
    cross_instance_family,

    pub const json_field_names = .{
        .same_instance_family = "SAME_INSTANCE_FAMILY",
        .cross_instance_family = "CROSS_INSTANCE_FAMILY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .same_instance_family => "SAME_INSTANCE_FAMILY",
            .cross_instance_family => "CROSS_INSTANCE_FAMILY",
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
