const std = @import("std");

pub const RecommendationType = enum {
    unused_permission_recommendation,

    pub const json_field_names = .{
        .unused_permission_recommendation = "UnusedPermissionRecommendation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unused_permission_recommendation => "UnusedPermissionRecommendation",
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
