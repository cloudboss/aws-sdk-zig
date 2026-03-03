const std = @import("std");

pub const ResourceType = enum {
    eks,
    ecs,
    ec2,

    pub const json_field_names = .{
        .eks = "EKS",
        .ecs = "ECS",
        .ec2 = "EC2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .eks => "EKS",
            .ecs => "ECS",
            .ec2 => "EC2",
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
