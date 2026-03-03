const std = @import("std");

pub const AdditionalResourceType = enum {
    helpful_resource,
    improvement_plan,

    pub const json_field_names = .{
        .helpful_resource = "HELPFUL_RESOURCE",
        .improvement_plan = "IMPROVEMENT_PLAN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .helpful_resource => "HELPFUL_RESOURCE",
            .improvement_plan => "IMPROVEMENT_PLAN",
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
