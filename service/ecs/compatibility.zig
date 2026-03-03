const std = @import("std");

pub const Compatibility = enum {
    ec2,
    fargate,
    external,
    managed_instances,

    pub const json_field_names = .{
        .ec2 = "EC2",
        .fargate = "FARGATE",
        .external = "EXTERNAL",
        .managed_instances = "MANAGED_INSTANCES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2 => "EC2",
            .fargate => "FARGATE",
            .external => "EXTERNAL",
            .managed_instances => "MANAGED_INSTANCES",
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
